//
//  ARExplorationView.swift
//  DunyaKasifiCan
//
//  Created by Can Kıraç on 20.04.2025.
//

import SwiftUI
import ARKit
import RealityKit

struct ARExplorationView: UIViewRepresentable {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var gameData: GameData
    @EnvironmentObject var appState: AppState
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        arView.session.run(config)
        
        setupARContent(arView: arView)
        setupGestureRecognizers(arView: arView)
        
        return arView
    }
    
    private func setupARContent(arView: ARView) {
        guard let currentCountry = userSession.currentCountry else { return }
        
        // Ülkenin önemli yapılarını yükle
        for landmark in currentCountry.landmarks {
            loadLandmark(landmark, in: arView)
        }
        
        // Bulutlardaki AR nesneleri
        addFlyingObjects(to: arView)
    }
    
    private func loadLandmark(_ landmark: Landmark, in arView: ARView) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let model = try? Entity.load(named: landmark.modelName) {
                DispatchQueue.main.async {
                    let anchor = AnchorEntity(plane: .horizontal)
                    model.scale = SIMD3<Float>(0.5, 0.5, 0.5)
                    anchor.addChild(model)
                    arView.scene.addAnchor(anchor)
                    
                    // Bilgi kartı ekle
                    addInfoCard(for: landmark, to: model, in: arView)
                }
            }
        }
    }
    
    private func addInfoCard(for landmark: Landmark, to entity: Entity, in arView: ARView) {
        let card = InfoCardView(landmark: landmark)
        let hostingController = UIHostingController(rootView: card)
        
        let width: CGFloat = 300
        let height: CGFloat = 200
        
        hostingController.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        hostingController.view.backgroundColor = UIColor.clear
        
        let material = UnlitMaterial(color: .clear)
        let mesh = MeshResource.generatePlane(width: Float(width) / 1000,
                                             height: Float(height) / 1000)
        
        let cardEntity = ModelEntity(mesh: mesh, materials: [material])
        cardEntity.position = [0, 0.2, 0]
        
        let anchor = AnchorEntity(world: entity.position(relativeTo: nil))
        anchor.addChild(cardEntity)
        arView.scene.addAnchor(anchor)
        
        let texture = try! TextureResource.generate(from: hostingController.view.cgImage!,
                                                  options: .init(semantic: .normal))
        var materialWithTexture = UnlitMaterial()
        materialWithTexture.baseColor = .texture(texture)
        cardEntity.model?.materials = [materialWithTexture]
    }
    
    private func addFlyingObjects(to arView: ARView) {
        let flyingObjects = ["bird", "airplane", "cloud", "ufo"]
        
        for objectName in flyingObjects {
            DispatchQueue.global(qos: .userInitiated).async {
                if let model = try? Entity.load(named: "\(objectName).usdz") {
                    DispatchQueue.main.async {
                        let randomPosition = simd_float3(
                            Float.random(in: -2...2),
                            Float.random(in: 1...3),
                            Float.random(in: -2...2)
                        )
                        
                        let anchor = AnchorEntity(world: randomPosition)
                        model.scale = SIMD3<Float>(0.3, 0.3, 0.3)
                        
                        // Animasyon ekle
                        let animation = makeFloatAnimation()
                        model.playAnimation(animation.repeat())
                        
                        anchor.addChild(model)
                        arView.scene.addAnchor(anchor)
                    }
                }
            }
        }
    }
    
    private func makeFloatAnimation() -> AnimationResource {
        let startTransform = Transform(scale: .one,
                                     rotation: .init(),
                                     translation: [0, 0, 0])
        let endTransform = Transform(scale: .one,
                                   rotation: .init(),
                                   translation: [0, 0.2, 0])
        
        return try! AnimationResource.generate(with: AnimationDefinition(
            name: "float",
            frames: [
                .init(timing: 0.0, transform: startTransform),
                .init(timing: 1.0, transform: endTransform),
                .init(timing: 2.0, transform: startTransform)
            ],
            loopMode: .loop
        ))
    }
    
    private func setupGestureRecognizers(arView: ARView) {
        let tapGesture = UITapGestureRecognizer(target: context.coordinator,
                                               action: #selector(Coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // AR içeriğini güncelle
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: ARExplorationView
        
        init(_ parent: ARExplorationView) {
            self.parent = parent
        }
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let arView = gesture.view as? ARView else { return }
            
            let tapLocation = gesture.location(in: arView)
            if let entity = arView.entity(at: tapLocation) {
                handleEntityTap(entity)
            }
        }
        
        private func handleEntityTap(_ entity: Entity) {
            // Dokunulan varlığa göre işlem yap
            print("Entity tapped: \(entity.name)")
        }
    }
}

struct InfoCardView: View {
    let landmark: Landmark
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(landmark.name)
                .font(.title2)
                .bold()
            
            Text("\(landmark.name) hakkında bilgi...")
                .font(.body)
            
            HStack {
                Image(systemName: "mappin")
                Text("Konum: \(landmark.name)")
            }
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(Color.white.opacity(0.9))
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

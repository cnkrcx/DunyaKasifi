import SwiftUI
import ARKit
import RealityKit

struct ARExplorerView: View {
    
    @StateObject var arViewModel: ARSceneViewModel
    
    @State private var isModelPlaced: Bool = false
    @State private var errorMessage: String?
    
    @State private var isARSessionRunning: Bool = false
    @State private var currentModel: String = "example_model"
    
    var body: some View {
        ZStack {
            ARViewContainer(arViewModel: arViewModel)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Spacer()
                
                if !isModelPlaced {
                    Button(action: {
                        placeModel()
                    }) {
                        Text("Place Model")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                
                HStack {
                    Button(action: {
                        resetARSession()
                    }) {
                        Text("Reset AR Session")
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        changeModel()
                    }) {
                        Text("Change Model")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            startARSession()
        }
    }
    
    func startARSession() {
        if !isARSessionRunning {
            arViewModel.startARSession()
            isARSessionRunning = true
        }
    }
    
    func placeModel() {
        guard let arView = arViewModel.arView else { return }
        
        if !isModelPlaced {
            arViewModel.addModelToScene(modelName: currentModel)
            isModelPlaced = true
        }
    }
    
    func resetARSession() {
        arViewModel.resetARSession()
        isModelPlaced = false
        errorMessage = nil
    }
    
    func changeModel() {
        let models = ["example_model", "model_2", "model_3"]
        if let currentIndex = models.firstIndex(of: currentModel) {
            let nextIndex = (currentIndex + 1) % models.count
            currentModel = models[nextIndex]
            isModelPlaced = false
            errorMessage = nil
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @ObservedObject var arViewModel: ARSceneViewModel
    
    func makeUIView(context: Context) -> ARView {
        return arViewModel.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // ARView güncelleniyor
    }
}

class ARSceneViewModel: ObservableObject {
    
    @Published var arView: ARView
    private var currentAnchor: AnchorEntity?
    
    init() {
        arView = ARView(frame: .zero)
        setupARView()
    }
    
    func startARSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func resetARSession() {
        arView.session.pause()
        startARSession()
    }
    
    func addModelToScene(modelName: String) {
        guard let modelEntity = try? ModelEntity.load(named: modelName) else {
            return
        }
        
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(modelEntity)
        arView.scene.addAnchor(anchor)
        currentAnchor = anchor
    }
    
    func removeModelFromScene() {
        if let anchor = currentAnchor {
            arView.scene.removeAnchor(anchor)
        }
    }
    
    func updateModelPosition(x: Float, y: Float, z: Float) {
        guard let anchor = currentAnchor else { return }
        anchor.position = SIMD3(x, y, z)
    }
    
    private func setupARView() {
        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        arView.environment.sceneUnderstanding.options.insert(.physics)
    }
}
// Placeholder for \(file) content.

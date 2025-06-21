import SwiftUI
import ARKit
import RealityKit

struct WindowARView: View {
    
    @StateObject var arViewModel: ARSceneViewModel
    @State private var isObjectPlaced = false
    @State private var errorMessage: String?
    @State private var selectedObject = "window_model"
    
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
                
                if !isObjectPlaced {
                    Button(action: {
                        placeObject()
                    }) {
                        Text("Pencereyi Yerleştir")
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
                        Text("AR Oturumunu Sıfırla")
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        changeObject()
                    }) {
                        Text("Objeyi Değiştir")
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
        arViewModel.startARSession()
    }
    
    func placeObject() {
        guard let arView = arViewModel.arView else { return }
        
        if !isObjectPlaced {
            arViewModel.addModelToScene(modelName: selectedObject)
            isObjectPlaced = true
        }
    }
    
    func resetARSession() {
        arViewModel.resetARSession()
        isObjectPlaced = false
        errorMessage = nil
    }
    
    func changeObject() {
        let objects = ["window_model", "door_model", "chair_model"]
        if let currentIndex = objects.firstIndex(of: selectedObject) {
            let nextIndex = (currentIndex + 1) % objects.count
            selectedObject = objects[nextIndex]
            isObjectPlaced = false
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

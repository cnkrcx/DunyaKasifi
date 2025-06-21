import UIKit
import SwiftUI
import ARKit
import RealityKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var arView: ARView!
    var currentScene: ARScene?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let contentView = ContentView()
        
        let hostingController = UIHostingController(rootView: contentView)
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
        
        setupARView()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("Scene did disconnect.")
        cleanUpAR()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("Scene did become active.")
        startARSession()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("Scene will resign active.")
        pauseARSession()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("Scene will enter foreground.")
        resumeARSession()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("Scene did enter background.")
        saveARState()
    }
    
    func setupARView() {
        arView = ARView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        arView.delegate = self
        arView.session.delegate = self
        
        let arSceneAnchor = try! Experience.loadScene()
        arView.scene.anchors.append(arSceneAnchor)
        
        let sceneTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        arView.addGestureRecognizer(sceneTapGesture)
    }
    
    func startARSession() {
        let config = ARWorldTrackingConfiguration()
        arView.session.run(config)
    }
    
    func pauseARSession() {
        arView.session.pause()
    }
    
    func resumeARSession() {
        let config = ARWorldTrackingConfiguration()
        arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func saveARState() {
        print("Saving AR state...")
    }
    
    func cleanUpAR() {
        arView = nil
    }
    
    func loadScene(sceneName: String) {
        if let arScene = ARScene(name: sceneName) {
            currentScene = arScene
            arView.scene.anchors.append(arScene.anchorEntity)
        }
    }

    @objc func handleTapGesture() {
        print("Scene tapped.")
    }

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        print("Frame updated: \(frame.timestamp)")
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchorEntity = anchor as? ARAnchor {
                let modelEntity = try! ModelEntity.loadModel(named: "3dObject")
                anchorEntity.addChild(modelEntity)
            }
        }
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        for anchor in anchors {
            print("Anchor removed: \(anchor.identifier)")
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("AR session failed: \(error.localizedDescription)")
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, ARKit!")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            ARViewRepresentable()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ARViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Eğer Sorun Olursa AR ekranını güncelle
    }
}

class ARScene {
    var name: String
    var anchorEntity: AnchorEntity
    
    init(name: String) {
        self.name = name
        self.anchorEntity = AnchorEntity(world: [0, 0, 0])
    }
}
/ \(file) - Placeholder for your code.

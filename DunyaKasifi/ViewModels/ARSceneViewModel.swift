import Foundation
import ARKit
import RealityKit
import Combine

class ARSceneViewModel: ObservableObject {
    
    @Published var arView: ARView
    @Published var currentAnchorEntity: AnchorEntity?
    @Published var isSessionRunning: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(arView: ARView) {
        self.arView = arView
        setupARSession()
    }
    
    func startARSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        isSessionRunning = true
    }
    
    func stopARSession() {
        arView.session.pause()
        isSessionRunning = false
    }
    
    func resetARSession() {
        arView.session.pause()
        arView.session.run(ARWorldTrackingConfiguration(), options: [.resetTracking, .removeExistingAnchors])
    }
    
    func addModelToScene(modelName: String) {
        guard let modelEntity = try? ModelEntity.load(named: modelName) else {
            errorMessage = "Model yüklenemedi"
            return
        }
        
        let anchorEntity = AnchorEntity(plane: .horizontal)
        anchorEntity.addChild(modelEntity)
        arView.scene.addAnchor(anchorEntity)
        
        currentAnchorEntity = anchorEntity
    }
    
    func removeModelFromScene() {
        if let anchor = currentAnchorEntity {
            arView.scene.removeAnchor(anchor)
            currentAnchorEntity = nil
        }
    }
    
    func updateModelPosition(x: Float, y: Float, z: Float) {
        guard let anchorEntity = currentAnchorEntity else {
            errorMessage = "Model bulunamadı"
            return
        }
        
        anchorEntity.position = SIMD3(x, y, z)
    }
    
    func handleARSessionError(_ error: Error) {
        errorMessage = error.localizedDescription
    }
    
    func handleARSessionInterrupted() {
        errorMessage = "AR oturumu kesildi. Lütfen tekrar deneyin."
    }
    
    func handleARSessionFailed(_ error: Error) {
        errorMessage = "AR oturumu başarısız oldu: \(error.localizedDescription)"
    }
    
    func handleARSessionStateChanged(_ state: ARSessionState) {
        switch state {
        case .running:
            errorMessage = nil
        case .failed(let error):
            handleARSessionFailed(error)
        case .interrupted:
            handleARSessionInterrupted()
        case .paused:
            errorMessage = "AR oturumu duraklatıldı"
        @unknown default:
            break
        }
    }
    
    func handleTapGesture(_ location: CGPoint) {
        let hitTestResults = arView.hitTest(location, types: .existingPlaneUsingExtent)
        guard let result = hitTestResults.first else {
            errorMessage = "Uygun bir yüzey bulunamadı"
            return
        }
        
        addModelToScene(modelName: "example_model")
        currentAnchorEntity?.position = result.worldTransform.translation
    }
    
    private func setupARSession() {
        arView.session.delegate = self
    }
}

extension ARSceneViewModel: ARSessionDelegate {
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // ARAnchor eklenince yapılacak işlemler
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        // ARAnchor güncellendiğinde yapılacak işlemler
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        // ARAnchor silindiğinde yapılacak işlemler
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // ARFrame güncellendiğinde yapılacak işlemler
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        handleARSessionError(error)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        handleARSessionInterrupted()
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        errorMessage = nil
    }
}

extension ARSessionState {
    var description: String {
        switch self {
        case .running:
            return "Çalışıyor"
        case .paused:
            return "Duraklatıldı"
        case .failed:
            return "Başarısız"
        case .interrupted:
            return "Kesildi"
        @unknown default:
            return "Bilinmeyen"
        }
    }
}
// Placeholder for \(file) content.

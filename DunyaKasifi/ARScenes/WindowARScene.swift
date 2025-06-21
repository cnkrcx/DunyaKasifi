import SwiftUI
import ARKit
import SceneKit

class WindowARScene: UIViewController, ARSCNViewDelegate {
    
    var arView: ARSCNView!
    var scene: SCNScene!
    var currentModelNode: SCNNode?
    var gestureRecognizer: UIGestureRecognizer!
    
    let windows = ["GlassWindow", "PortalWindow", "CityView"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(arView)
        
        arView.delegate = self
        arView.autoenablesDefaultLighting = true
        
        scene = SCNScene()
        arView.scene = scene
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
        
        addWindowModel(named: "GlassWindow")
        setupGestureRecognizers()
    }
    
    func addWindowModel(named modelName: String) {
        guard let modelScene = SCNScene(named: "art.scnassets/\(modelName).scn") else { return }
        let modelNode = modelScene.rootNode
        modelNode.position = SCNVector3(x: 0, y: 0, z: -1)
        scene.rootNode.addChildNode(modelNode)
        currentModelNode = modelNode
    }
    
    func setupGestureRecognizers() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        arView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: arView)
        let hitTestResults = arView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if let result = hitTestResults.first {
            addModelAtLocation(hitResult: result)
        }
    }
    
    func addModelAtLocation(hitResult: ARHitTestResult) {
        guard let modelScene = SCNScene(named: "art.scnassets/PortalWindow.scn") else { return }
        let modelNode = modelScene.rootNode
        modelNode.position = SCNVector3(hitResult.worldTransform.columns.3.x,
                                        hitResult.worldTransform.columns.3.y,
                                        hitResult.worldTransform.columns.3.z)
        scene.rootNode.addChildNode(modelNode)
        currentModelNode = modelNode
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("AR Session failed with error: \(error.localizedDescription)")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("AR Session was interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("AR Session interruption ended")
    }
    
    func resetScene() {
        for node in scene.rootNode.childNodes {
            node.removeFromParentNode()
        }
        addWindowModel(named: "GlassWindow")
    }
    
    func addInteractiveOverlay() {
        let overlayNode = SCNNode(geometry: SCNSphere(radius: 0.05))
        overlayNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        overlayNode.position = SCNVector3(x: 0, y: 0.5, z: -1)
        scene.rootNode.addChildNode(overlayNode)
    }
    
    func animateModel(node: SCNNode) {
        let moveUp = SCNAction.moveBy(x: 0, y: 0.1, z: 0, duration: 1.0)
        let moveDown = SCNAction.moveBy(x: 0, y: -0.1, z: 0, duration: 1.0)
        let sequence = SCNAction.sequence([moveUp, moveDown])
        let repeatAction = SCNAction.repeatForever(sequence)
        node.runAction(repeatAction)
    }
    
    func applyRotationToModel(node: SCNNode) {
        let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat.pi, z: 0, duration: 5.0)
        let repeatAction = SCNAction.repeatForever(rotateAction)
        node.runAction(repeatAction)
    }
    
    func applyLightingEffect(node: SCNNode) {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .directional
        lightNode.position = SCNVector3(x: 0, y: 5, z: 5)
        node.addChildNode(lightNode)
    }
    
    func create3DTextLabel(text: String) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 1)
        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(x: 0, y: 0, z: -1)
        return textNode
    }
    
    func animateTextLabel(node: SCNNode) {
        let fadeOut = SCNAction.fadeOpacity(to: 0, duration: 2.0)
        let fadeIn = SCNAction.fadeOpacity(to: 1, duration: 2.0)
        let sequence = SCNAction.sequence([fadeOut, fadeIn])
        let repeatAction = SCNAction.repeatForever(sequence)
        node.runAction(repeatAction)
    }
    
    func addInteractionForWindowModel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapForModel(_:)))
        arView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapForModel(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: arView)
        let hitTestResults = arView.hitTest(touchLocation, options: nil)
        
        if let hitNode = hitTestResults.first?.node {
            animateModel(node: hitNode)
            applyLightingEffect(node: hitNode)
            applyRotationToModel(node: hitNode)
        }
    }
    
    func setupGestures() {
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
        arView.addGestureRecognizer(rotateGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        arView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handleRotate(_ sender: UIRotationGestureRecognizer) {
        let rotation = sender.rotation
        currentModelNode?.eulerAngles.y += Float(rotation)
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        currentModelNode?.scale = SCNVector3(x: Float(scale), y: Float(scale), z: Float(scale))
    }
    
    func setupCameraControls() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 1, z: 5)
        scene.rootNode.addChildNode(cameraNode)
    }
    
    func setupInteractionNode() {
        let interactionNode = SCNNode()
        interactionNode.geometry = SCNSphere(radius: 0.2)
        interactionNode.position = SCNVector3(x: 0, y: 0, z: -1)
        scene.rootNode.addChildNode(interactionNode)
        interactionNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
    }
    
    func resetARSession() {
        arView.session.pause()
        arView.session.run(ARWorldTrackingConfiguration(), options: [.resetTracking, .removeExistingAnchors])
    }
}

struct WindowARSceneView: View {
    var body: some View {
        WindowARSceneWrapper()
            .edgesIgnoringSafeArea(.all)
    }
}

struct WindowARSceneWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> WindowARScene {
        return WindowARScene()
    }

    func updateUIViewController(_ uiViewController: WindowARScene, context: Context) {}
}

struct WindowARScene_Previews: PreviewProvider {
    static var previews: some View {
        WindowARSceneView()
    }
}
// Placeholder for \(file) content.

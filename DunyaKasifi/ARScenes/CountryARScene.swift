import SwiftUI
import ARKit
import SceneKit

class CountryARScene: UIViewController, ARSCNViewDelegate {

    var arView: ARSCNView!
    var scene: SCNScene!
    var currentModelNode: SCNNode?

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
        
        addCountryModel(named: "EiffelTower")
        addInteractiveObject(named: "Plane")
    }

    func addCountryModel(named modelName: String) {
        guard let modelScene = SCNScene(named: "art.scnassets/\(modelName).scn") else { return }
        let modelNode = modelScene.rootNode
        modelNode.position = SCNVector3(x: 0, y: 0, z: -1)
        scene.rootNode.addChildNode(modelNode)
        currentModelNode = modelNode
    }

    func addInteractiveObject(named objectName: String) {
        let planeGeometry = SCNPlane(width: 0.5, height: 0.5)
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3(x: 0, y: -0.5, z: -1)
        planeNode.rotation = SCNVector4(1, 0, 0, Float.pi / 2)
        
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        scene.rootNode.addChildNode(planeNode)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: arView)
        let hitTestResults = arView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if let result = hitTestResults.first {
            addModelAtLocation(hitResult: result)
        }
    }

    func addModelAtLocation(hitResult: ARHitTestResult) {
        guard let modelScene = SCNScene(named: "art.scnassets/Plane.scn") else { return }
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

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        if let currentNode = currentModelNode {
            currentNode.position = SCNVector3(frame.camera.transform.columns.3.x,
                                              frame.camera.transform.columns.3.y,
                                              frame.camera.transform.columns.3.z - 1)
        }
    }

    func resetScene() {
        for node in scene.rootNode.childNodes {
            node.removeFromParentNode()
        }
        addCountryModel(named: "EiffelTower")
    }

    func addCountryAnnotations() {
        let annotationNode = SCNNode(geometry: SCNSphere(radius: 0.05))
        annotationNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        annotationNode.position = SCNVector3(x: 0, y: 0.5, z: -1)
        scene.rootNode.addChildNode(annotationNode)
    }

    func animateModel(node: SCNNode) {
        let moveUp = SCNAction.moveBy(x: 0, y: 0.1, z: 0, duration: 1.0)
        let moveDown = SCNAction.moveBy(x: 0, y: -0.1, z: 0, duration: 1.0)
        let sequence = SCNAction.sequence([moveUp, moveDown])
        let repeatAction = SCNAction.repeatForever(sequence)
        node.runAction(repeatAction)
    }

    func addRotationToModel(node: SCNNode) {
        let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat.pi, z: 0, duration: 5.0)
        let repeatRotation = SCNAction.repeatForever(rotateAction)
        node.runAction(repeatRotation)
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

    func addInteractionForCountryModel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapForModel(_:)))
        arView.addGestureRecognizer(tapGesture)
    }

    @objc func handleTapForModel(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: arView)
        let hitTestResults = arView.hitTest(touchLocation, options: nil)
        
        if let hitNode = hitTestResults.first?.node {
            animateModel(node: hitNode)
            applyLightingEffect(node: hitNode)
            addRotationToModel(node: hitNode)
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

struct CountryARSceneView: View {
    var body: some View {
        CountryARSceneWrapper()
            .edgesIgnoringSafeArea(.all)
    }
}

struct CountryARSceneWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CountryARScene {
        return CountryARScene()
    }

    func updateUIViewController(_ uiViewController: CountryARScene, context: Context) {}
}

struct CountryARScene_Previews: PreviewProvider {
    static var previews: some View {
        CountryARSceneView()
    }
}
// Placeholder for \(file) content.

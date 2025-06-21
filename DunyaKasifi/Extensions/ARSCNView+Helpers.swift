import ARKit
import SceneKit

extension ARSCNView {
    
    func setupARSession(configuration: ARWorldTrackingConfiguration) {
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        self.delegate = self
        self.autoenablesDefaultLighting = true
        self.showsStatistics = true
    }
    
    func addTapGestureRecognizer(target: Any, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
    }
    
    func addPanGestureRecognizer(target: Any, action: Selector) {
        let panGesture = UIPanGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(panGesture)
    }
    
    func addPinchGestureRecognizer(target: Any, action: Selector) {
        let pinchGesture = UIPinchGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(pinchGesture)
    }
    
    func addRotationGestureRecognizer(target: Any, action: Selector) {
        let rotationGesture = UIRotationGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(rotationGesture)
    }
    
    func hitTestWithResultType(_ location: CGPoint, resultType: ARHitTestResult.ResultType = .existingPlaneUsingExtent) -> [ARHitTestResult] {
        return self.hitTest(location, types: resultType)
    }
    
    func add3DModel(named modelName: String, at location: SCNVector3) -> SCNNode? {
        guard let scene = SCNScene(named: "art.scnassets/\(modelName).scn") else { return nil }
        let node = scene.rootNode
        node.position = location
        self.scene.rootNode.addChildNode(node)
        return node
    }
    
    func removeNode(_ node: SCNNode) {
        node.removeFromParentNode()
    }
    
    func addLighting(to node: SCNNode) {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .directional
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        node.addChildNode(lightNode)
    }
    
    func animateNode(_ node: SCNNode, to position: SCNVector3, duration: TimeInterval = 1.0) {
        let moveAction = SCNAction.move(to: position, duration: duration)
        node.runAction(moveAction)
    }
    
    func rotateNode(_ node: SCNNode, by angle: CGFloat, duration: TimeInterval = 1.0) {
        let rotateAction = SCNAction.rotateBy(x: 0, y: angle, z: 0, duration: duration)
        node.runAction(rotateAction)
    }
    
    func scaleNode(_ node: SCNNode, by factor: Float, duration: TimeInterval = 1.0) {
        let scaleAction = SCNAction.scale(by: CGFloat(factor), duration: duration)
        node.runAction(scaleAction)
    }
    
    func getNode(at location: CGPoint) -> SCNNode? {
        let hitTestResults = self.hitTestWithResultType(location)
        guard let result = hitTestResults.first else { return nil }
        return result.node
    }
    
    func addTextLabel(at position: SCNVector3, text: String) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 1)
        let textNode = SCNNode(geometry: textGeometry)
        textNode.position = position
        textNode.scale = SCNVector3(0.1, 0.1, 0.1)
        self.scene.rootNode.addChildNode(textNode)
        return textNode
    }
    
    func updateTextLabel(_ labelNode: SCNNode, with newText: String) {
        guard let textGeometry = labelNode.geometry as? SCNText else { return }
        textGeometry.string = newText
    }
    
    func placeObject(at point: CGPoint, using modelName: String) {
        let hitTestResults = self.hitTestWithResultType(point, resultType: .existingPlaneUsingExtent)
        if let result = hitTestResults.first {
            let position = SCNVector3(result.worldTransform.columns.3.x,
                                      result.worldTransform.columns.3.y,
                                      result.worldTransform.columns.3.z)
            self.add3DModel(named: modelName, at: position)
        }
    }
    
    func createNodeForHitTestResult(_ hitResult: ARHitTestResult) -> SCNNode {
        let node = SCNNode(geometry: SCNSphere(radius: 0.1))
        node.position = SCNVector3(hitResult.worldTransform.columns.3.x,
                                   hitResult.worldTransform.columns.3.y,
                                   hitResult.worldTransform.columns.3.z)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        return node
    }
    
    func placeModelOnPlane(at location: CGPoint, modelName: String) {
        let hitTestResults = self.hitTest(location, types: .existingPlaneUsingExtent)
        if let result = hitTestResults.first {
            let position = SCNVector3(result.worldTransform.columns.3.x,
                                      result.worldTransform.columns.3.y,
                                      result.worldTransform.columns.3.z)
            let modelNode = self.add3DModel(named: modelName, at: position)
            self.addLighting(to: modelNode!)
        }
    }
    
    func addPlaneNode(at location: SCNVector3, width: CGFloat = 0.5, height: CGFloat = 0.5) -> SCNNode {
        let plane = SCNPlane(width: width, height: height)
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = location
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.5)
        self.scene.rootNode.addChildNode(planeNode)
        return planeNode
    }
    
    func adjustCameraToFocusOnNode(_ node: SCNNode) {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(node.position.x, node.position.y, node.position.z + 2)
        self.scene.rootNode.addChildNode(cameraNode)
        self.pointOfView = cameraNode
    }
    
    func startSessionWithPlaneDetection() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        self.session.run(configuration)
    }
    
    func stopARSession() {
        self.session.pause()
    }
    
    func resetARSession() {
        self.session.pause()
        let configuration = ARWorldTrackingConfiguration()
        self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func addSphere(at location: SCNVector3, radius: CGFloat = 0.1) -> SCNNode {
        let sphere = SCNSphere(radius: radius)
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = location
        self.scene.rootNode.addChildNode(sphereNode)
        return sphereNode
    }
    
    func addCube(at location: SCNVector3, size: CGFloat = 0.1) -> SCNNode {
        let box = SCNBox(width: size, height: size, length: size, chamferRadius: 0)
        let boxNode = SCNNode(geometry: box)
        boxNode.position = location
        self.scene.rootNode.addChildNode(boxNode)
        return boxNode
    }
    
    func animateNodeToPosition(_ node: SCNNode, targetPosition: SCNVector3, duration: TimeInterval) {
        let moveAction = SCNAction.move(to: targetPosition, duration: duration)
        node.runAction(moveAction)
    }
    
    func rotateNodeToTarget(_ node: SCNNode, targetRotation: SCNVector4, duration: TimeInterval) {
        let rotateAction = SCNAction.rotate(to: targetRotation, duration: duration)
        node.runAction(rotateAction)
    }
    
    func scaleNodeToTarget(_ node: SCNNode, targetScale: SCNVector3, duration: TimeInterval) {
        let scaleAction = SCNAction.scale(to: targetScale, duration: duration)
        node.runAction(scaleAction)
    }
    
    func toggleVisibility(of node: SCNNode) {
        node.isHidden = !node.isHidden
    }
    
    func addLightToNode(_ node: SCNNode) {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(node.position.x, node.position.y + 1, node.position.z)
        node.addChildNode(lightNode)
    }
    
    func applyEffectToNode(_ node: SCNNode, effect: String) {
        switch effect {
        case "glow":
            let glowAction = SCNAction.fadeOpacity(to: 0.5, duration: 1)
            node.runAction(glowAction)
        default:
            break
        }
    }
    
    func placeObjectOnHitTestPlane(location: CGPoint) {
        let hitTestResults = self.hitTest(location, types: .existingPlaneUsingExtent)
        if let result = hitTestResults.first {
            let position = SCNVector3(result.worldTransform.columns.3.x,
                                      result.worldTransform.columns.3.y,
                                      result.worldTransform.columns.3.z)
            let modelNode = self.add3DModel(named: "CityView", at: position)
            self.addLighting(to: modelNode!)
        }
    }
}

// Placeholder for \(file) content.

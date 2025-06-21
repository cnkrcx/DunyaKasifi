import UIKit

extension UIView {
    
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func setBorderColor(_ color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func setShadow(color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
    }
    
    func roundTopCorners(radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    func roundBottomCorners(radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    func setGradientBackground(colors: [UIColor], direction: GradientDirection = .topToBottom) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addBlurEffect(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func addGradientBorder(colors: [UIColor], width: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shapeLayer.lineWidth = width
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.clear.cgColor
        gradientLayer.mask = shapeLayer
        layer.addSublayer(gradientLayer)
    }
    
    func bounceAnimation() {
        let bounce = CABasicAnimation(keyPath: "transform.scale")
        bounce.fromValue = 1.0
        bounce.toValue = 1.1
        bounce.duration = 0.2
        bounce.autoreverses = true
        bounce.repeatCount = 2
        self.layer.add(bounce, forKey: "bounce")
    }
    
    func shakeAnimation() {
        let shake = CAKeyframeAnimation(keyPath: "position")
        shake.values = [
            NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y)),
            NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y)),
            NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y)),
            NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y)),
            NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        ]
        shake.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        shake.duration = 0.4
        self.layer.add(shake, forKey: "shake")
    }
    
    func pulseAnimation() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.fromValue = 1.0
        pulse.toValue = 1.05
        pulse.duration = 0.6
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        self.layer.add(pulse, forKey: "pulse")
    }
    
    func addShadow(color: UIColor, offset: CGSize, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 1) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotationAnimation.duration = duration
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func slideInFromTop(duration: CFTimeInterval = 0.5) {
        let slideInAnimation = CABasicAnimation(keyPath: "position.y")
        slideInAnimation.fromValue = self.layer.position.y - 100
        slideInAnimation.toValue = self.layer.position.y
        slideInAnimation.duration = duration
        slideInAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        self.layer.add(slideInAnimation, forKey: "slideInFromTop")
    }
    
    func slideOutToBottom(duration: CFTimeInterval = 0.5) {
        let slideOutAnimation = CABasicAnimation(keyPath: "position.y")
        slideOutAnimation.fromValue = self.layer.position.y
        slideOutAnimation.toValue = self.layer.position.y + 100
        slideOutAnimation.duration = duration
        slideOutAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        self.layer.add(slideOutAnimation, forKey: "slideOutToBottom")
    }
    
    func pulseEffect(duration: CFTimeInterval = 1.5) {
        let pulse = CAKeyframeAnimation(keyPath: "transform.scale")
        pulse.values = [1.0, 1.1, 1.0]
        pulse.keyTimes = [0, 0.5, 1]
        pulse.duration = duration
        pulse.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(pulse, forKey: "pulseEffect")
    }
    
    func applyGradientWithDirection(colors: [UIColor], direction: GradientDirection) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

enum GradientDirection {
    case topToBottom
    case leftToRight
    case bottomToTop
    case rightToLeft
    
    var startPoint: CGPoint {
        switch self {
        case .topToBottom:
            return CGPoint(x: 0.5, y: 0)
        case .leftToRight:
            return CGPoint(x: 0, y: 0.5)
        case .bottomToTop:
            return CGPoint(x: 0.5, y: 1)
        case .rightToLeft:
            return CGPoint(x: 1, y: 0.5)
        }
    }
    
    var endPoint: CGPoint {
        switch self {
        case .topToBottom:
            return CGPoint(x: 0.5, y: 1)
        case .leftToRight:
            return CGPoint(x: 1, y: 0.5)
        case .bottomToTop:
            return CGPoint(x: 0.5, y: 0)
        case .rightToLeft:
            return CGPoint(x: 0, y: 0.5)
        }
    }
}
// Placeholder for \(file) content.

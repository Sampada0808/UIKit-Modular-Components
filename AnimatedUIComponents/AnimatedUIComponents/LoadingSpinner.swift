import UIKit

final class LoadingSpinner: UIView {
    
    // MARK: - Customizable Properties
    var spinnerColor: UIColor = .systemPurple {
        didSet { innerSpinnerPath.strokeColor = spinnerColor.cgColor }
    }
    
    var trackColor: UIColor = .lightGray {
        didSet { outerSpinnerPath.strokeColor = trackColor.cgColor }
    }
    
    var lineWidth: CGFloat = 8 {
        didSet {
            outerSpinnerPath.lineWidth = lineWidth
            innerSpinnerPath.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    var rotationSpeed: CFTimeInterval = 1.0
    
    // MARK: - Layers
    private let outerSpinnerPath = CAShapeLayer()
    private let innerSpinnerPath = CAShapeLayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    convenience init(color: UIColor = .systemPurple, lineWidth: CGFloat = 8, speed: CFTimeInterval = 1.0) {
        self.init(frame: .zero)
        self.spinnerColor = color
        self.lineWidth = lineWidth
        self.rotationSpeed = speed
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePaths()
    }
    
    private func setupLayers() {
        innerSpinnerPath.fillColor = UIColor.clear.cgColor
        innerSpinnerPath.strokeColor = spinnerColor.cgColor
        innerSpinnerPath.lineCap = .round
        
        outerSpinnerPath.fillColor = UIColor.clear.cgColor
        outerSpinnerPath.strokeColor = trackColor.cgColor
        outerSpinnerPath.lineCap = .round
        
        layer.addSublayer(outerSpinnerPath)
        layer.addSublayer(innerSpinnerPath)
        
        self.alpha = 0 
    }
    
    private func updatePaths() {
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let outerPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: CGFloat.pi * 1.5,
            clockwise: true
        )
        
        let innerPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: 0,
            clockwise: true
        )
        
        outerSpinnerPath.path = outerPath.cgPath
        innerSpinnerPath.path = innerPath.cgPath
        outerSpinnerPath.lineWidth = lineWidth
        innerSpinnerPath.lineWidth = lineWidth
    }
    
    // MARK: - Control Methods
    func startAnimation() {
        self.alpha = 1
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = rotationSpeed
        rotation.repeatCount = .infinity
        rotation.isRemovedOnCompletion = false
        
        layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { _ in
            self.layer.removeAnimation(forKey: "rotationAnimation")
        }
    }
}

import UIKit

final class BounceButton: UIButton {

    // MARK: - Customizable Properties
    var bounceScale: CGFloat = 0.7
    var bounceDuration: TimeInterval = 0.3
    var springDamping: CGFloat = 0.4
    var initialVelocity: CGFloat = 3.0

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        backgroundColor = .systemPurple
        setTitle("Bounce", for: .normal)
        setTitleColor(.white, for: .normal)
        addTarget(self, action: #selector(performBounce), for: .touchUpInside)
    }

    @objc private func performBounce() {
        UIView.animate(withDuration: bounceDuration, animations: {
            self.transform = CGAffineTransform(scaleX: self.bounceScale, y: self.bounceScale)
        }) { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: self.springDamping,
                           initialSpringVelocity: self.initialVelocity,
                           options: .curveEaseOut,
                           animations: {
                self.transform = .identity
            })
        }
    }
}

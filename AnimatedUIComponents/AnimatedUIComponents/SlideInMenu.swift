import UIKit

// MARK: - Protocol
protocol SideMenuViewDelegate: AnyObject {
    func didSelectMenuItem(_ title: String)
}

// MARK: - SideMenuView
class SideMenuView: UIView {
    
    // MARK: - Properties
    weak var delegate: SideMenuViewDelegate?

    private var stackView: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        vStack.alignment = .leading
        vStack.spacing = 0
        return vStack
    }()
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return view
    }()

    private var isVisible = false
    private var widthMultiplier: CGFloat = 0.5

    // MARK: - Initializers
    init(menuTitles: [String] = []) {
        super.init(frame: .zero)
        setupUI()
        menuTitles.forEach { addMenuItem(title: $0) }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundView)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }

    
    // MARK: - Public Methods
    func addMenuItem(title: String) {
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        label.addGestureRecognizer(tap)

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label.topAnchor.constraint(equalTo: container.topAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
        ])

        stackView.addArrangedSubview(container)
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel,
              let title = label.text else { return }
        delegate?.didSelectMenuItem(title)
        hide()
    }

    func show(in parentView: UIView) {
        if isVisible { return }

        parentView.addSubview(self)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            topAnchor.constraint(equalTo: parentView.topAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: widthMultiplier)
        ])
        parentView.layoutIfNeeded()
        
        transform = CGAffineTransform(translationX: -parentView.bounds.width * widthMultiplier, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.transform = .identity
        }, completion: { _ in
            self.isVisible = true
        })
    }

    func hide() {
        guard let superview = superview else { return }

        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.transform = CGAffineTransform(translationX: -superview.bounds.width * self.widthMultiplier, y: 0)
        }, completion: { _ in
            self.removeFromSuperview()
            self.isVisible = false
        })
    }
}

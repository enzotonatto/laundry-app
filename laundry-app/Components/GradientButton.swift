import UIKit

class GradientButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    private let tapAreaPadding: CGFloat = 10 // Extra padding to ensure tappability
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = Fonts.title3
        label.isUserInteractionEnabled = false // Disable interaction
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .white
        image.isUserInteractionEnabled = false // Disable interaction
        return image
    }()
    
    lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [label, image])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false // Disable interaction
        return stack
    }()
    
    var isShowingIcon: Bool = true {
        didSet {
            updateIconVisibility()
        }
    }
    
    var font: UIFont? {
        didSet {
            label.font = font
        }
    }
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
        setGradientColors([.startGradient, .endGradient])
        setup()
        configureTouchHandling()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTouchHandling() {
        isUserInteractionEnabled = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    func updateIconVisibility() {
        image.isHidden = !isShowingIcon
    }
    
    func setGradientColors(_ colors: [UIColor]) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }
    
    // Expand the tappable area if needed
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let expandedBounds = bounds.insetBy(dx: -tapAreaPadding, dy: -tapAreaPadding)
        return expandedBounds.contains(point)
    }
}

extension GradientButton: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 57), // Maintain original height
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Ensure content is properly padded
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }
}

class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    func configureGradient(colors: [UIColor]) {
        guard let gradientLayer = layer as? CAGradientLayer else { return }
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
}

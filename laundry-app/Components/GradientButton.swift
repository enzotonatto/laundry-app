import UIKit
import Foundation


class GradientButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = Fonts.title3
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .white
        return image
    }()
    
    lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [label, image])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var background: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var isShowingIcon: Bool = true {
        didSet{
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
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
        setGradientColors([.startGradient, .endGradient])
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    
    func updateIconVisibility(){
        if isShowingIcon {
            image.isHidden = false
        } else {
            image.isHidden = true
        }
    }

    
    func setGradientColors(_ colors: [UIColor]) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }
        
}

extension GradientButton: ViewCodeProtocol {
    func addSubViews() {
        addSubview(background)
        background.addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            background.heightAnchor.constraint(equalToConstant: 57),
            background.widthAnchor.constraint(equalToConstant: 361),
            
            stack.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: background.centerYAnchor),
        ])
    }
    
    
}


class GradientView: UIView {
    override class var layerClass: AnyClass{
        return CAGradientLayer.self
    }
    
    func configureGradient(colors: [UIColor]){
        
        guard let gradientLayer = layer as? CAGradientLayer else {return}
        gradientLayer.colors = colors.map {$0.cgColor}
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
}


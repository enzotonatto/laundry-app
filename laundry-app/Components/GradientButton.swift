import UIKit
import Foundation


class GradientButton: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    let iconName: String = "chevron.right"
        
    lazy var button: UIButton = {
        var button = UIButton() 
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let image = UIImage(systemName: iconName, withConfiguration: config)
        button.setImage(isShowingIcon ? image : nil, for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .center
        button.adjustsImageWhenHighlighted = false
        button.contentVerticalAlignment = .center
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)

        return button
    }()
    
    var isShowingIcon: Bool = true {
        didSet{
            updateIconVisibility()
        }
    }
    
    var font: UIFont? {
        didSet {
            button.titleLabel?.font = font
        }
    }
    
    var title: String? {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }
    
    


    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setup()
        layer.insertSublayer(gradientLayer, at: 0)
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
            button.setImage(UIImage(systemName: iconName), for: .normal)
            button.semanticContentAttribute = .forceRightToLeft
        } else {
            button.setImage(UIImage(systemName: ""), for: .normal)
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
        addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 57),
            button.widthAnchor.constraint(equalToConstant: 361),
            
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
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

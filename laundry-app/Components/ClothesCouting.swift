//
//  ClothesCouting.swift
//  pocClothesCounting
//
//  Created by Antonio Costa on 17/06/25.
//

import Foundation
import UIKit



class ClothesCouting: UIView, UITextFieldDelegate {
    weak var delegate: ClothesCoutingDelegate?
    
    lazy var iconImage: UIImageView = {
        var icon = UIImageView()
        icon.tintColor = .accent
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(systemName: imageName ?? "tshirt.fill")
        icon.setContentHuggingPriority(.required, for: .horizontal)
        
        if let imageName = imageName, let sfImage = UIImage(systemName: imageName) {
            icon.image = sfImage
        } else if let imageName = imageName, let assetImage = UIImage(named: imageName) {
            icon.image = assetImage
        } else {
            icon.image = UIImage(systemName: "tshirt.fill")
        }
        return icon
    }()
    
    lazy var clothesName: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.text = "".capitalized
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var countTF: UITextField = {
             let tf = UITextField()
             tf.text = "\(count)"
             tf.textColor = .label
             tf.backgroundColor = .tertiarySystemFill
             tf.layer.cornerRadius = 16
             tf.clipsToBounds = true
             tf.delegate = self
             tf.textAlignment = .center
             tf.keyboardType = .numberPad
             tf.addTarget(self, action: #selector(editingDidEnd(_ :)), for: .editingDidEnd)
             return tf
         }()
    
    lazy var decrementButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(didTapDecrement), for: .touchUpInside)
        button.tintColor = .secondaryLabel
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    lazy var incrementButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(didTapIncrement), for: .touchUpInside)
        button.tintColor = .accent
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiaryLabel
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var constrolsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [decrementButton, separator, incrementButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.layer.cornerRadius = 16
        stack.backgroundColor = .tertiarySystemFill
        stack.clipsToBounds = true
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.masksToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImage, clothesName, countTF, constrolsStack])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var count: Int = 0 {
        didSet {
            countTF.text = "\(count)"
            decrementButton.isEnabled = count > 0
            delegate?.counterDidChange(count: count, for: self)
        }
    }
    
    var title: String? {
        didSet{
            clothesName.text = title
        }
    }
    
    var imageName: String? {
        didSet{
            if let sfImage = UIImage(systemName: imageName ?? "") {
                iconImage.image = sfImage
            } else if let assetImage = UIImage(named: imageName ?? "") {
                iconImage.image = assetImage
            } else {
                iconImage.image = UIImage(systemName: "tshirt.fill")
            }
        }
    }
    
    
    func getCount() -> Int {
        return count
    }
    
    func setCount(_ value: Int){
        count = value
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
             let invalid = CharacterSet.decimalDigits.inverted
             if string.rangeOfCharacter(from: invalid) != nil {


                 return false
             }
             let current = textField.text ?? ""
             guard let r = Range(range, in: current) else { return false }
             let updated = current.replacingCharacters(in: r, with: string)
             if updated.isEmpty {
                 return true
             }
             if updated.count > 2 {
                 return false
             }
             if let v = Int(updated), v >= 0 && v <= 99 {
                 return true
             }
             return false
         }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        layer.masksToBounds = true
        setup()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

    @objc func didTapDecrement(){
        if count > 0 {
            count -= 1
        }
    }
    @objc func didTapIncrement(){
        if count < 99 {
            count += 1
        }
    }
    
    @objc private func editingDidEnd(_ tf: UITextField) {
             let v = Int(tf.text ?? "") ?? 0


             count = min(max(v,0), 99)
         }
    
    
    
}

protocol ClothesCoutingDelegate: AnyObject {
    func counterDidChange(count: Int, for counter: ClothesCouting)
}

extension ClothesCouting: ViewCodeProtocol{
    func addSubViews() {
        addSubview(mainStack)
        constrolsStack.addSubview(separator)
        mainStack.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.heightAnchor.constraint(equalToConstant: 54),
                        
            decrementButton.widthAnchor.constraint(equalToConstant: 32),
            decrementButton.heightAnchor.constraint(equalToConstant: 32),
            
            incrementButton.widthAnchor.constraint(equalToConstant: 32),
            incrementButton.heightAnchor.constraint(equalToConstant: 32),
            
            iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            constrolsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            constrolsStack.heightAnchor.constraint(equalToConstant: 32),
            constrolsStack.widthAnchor.constraint(equalToConstant: 94),

            separator.centerXAnchor.constraint(equalTo: constrolsStack.centerXAnchor),
            separator.topAnchor.constraint(equalTo: constrolsStack.topAnchor, constant: 7),
            separator.bottomAnchor.constraint(equalTo: constrolsStack.bottomAnchor, constant: -7),
            separator.widthAnchor.constraint(equalToConstant: 0.5),
            separator.heightAnchor.constraint(equalToConstant: 18),
            
            
            countTF.heightAnchor.constraint(equalToConstant: 32),
            countTF.widthAnchor.constraint(equalToConstant: 47),
            
            iconImage.heightAnchor.constraint(equalToConstant: 33),
            iconImage.widthAnchor.constraint(equalToConstant: 44)
            
        ])
    }
}

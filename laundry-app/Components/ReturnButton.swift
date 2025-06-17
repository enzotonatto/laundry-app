//
//  ReturnButton.swift
//  UIKitCodeView
//
//  Created by Antonio Costa on 16/06/25.
//

import Foundation
import UIKit

class ReturnButton: UIButton {

    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Voltar"
        label.textColor = .white
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.backward")
        image.tintColor = .white
        return image
    }()
    
    lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [image, label])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .accent
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ReturnButton: ViewCodeProtocol {
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
            
            background.heightAnchor.constraint(equalToConstant: 30),
            background.widthAnchor.constraint(equalToConstant: 78),
            
            stack.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            
            
        ])
    }
    
    
}

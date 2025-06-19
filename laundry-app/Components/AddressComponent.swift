//
//  AddressComponent.swift
//  laundry-app
//
//  Created by Gustavo Melleu on 18/06/25.
//

import Foundation
import UIKit

class AddressComponent : UIView {
    
    lazy var labelText: UILabel = {
        let label = UILabel()
        label.font = Fonts.body
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.systemGray6
        textField.layer.cornerRadius = 32
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = .darkGray
        textField.setLeftPaddingPoints(16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    

    lazy var stackMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelText, textField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(label: String, placeholder: String) {
           labelText.text = label
           textField.placeholder = placeholder
       }

    public var text: String? {
          return textField.text
      }
    
}

extension AddressComponent  : ViewCodeProtocol {
    func addSubViews() {
        addSubview(stackMain)
   
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
     
                stackMain.topAnchor.constraint(equalTo: topAnchor),
                stackMain.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackMain.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackMain.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                textField.heightAnchor.constraint(equalToConstant: 60) 
           
            
            
        ])
    }
    
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

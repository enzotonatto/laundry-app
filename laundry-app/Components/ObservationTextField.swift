//
//  ObservationTextField.swift
//  laundry-app
//
//  Created by Antonio Costa on 18/06/25.
//

import Foundation
import UIKit

class ObservationTextField: UIView {
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Observação"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.title3
        return label
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Observação"
        tf.layer.cornerRadius = 32
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setLeftPaddingPoints(16)

        return tf
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.layer.cornerRadius = textField.bounds.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.backgroundColor = .secondarySystemBackground
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ObservationTextField: ViewCodeProtocol{
    func addSubViews() {
        addSubview(title)
        addSubview(textField)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            textField.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}

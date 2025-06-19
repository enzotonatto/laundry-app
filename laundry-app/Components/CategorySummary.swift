//
//  CategorySummary.swift
//  laundry-app
//
//  Created by Antonio Costa on 18/06/25.
//

import Foundation
import UIKit

class CategorySummary: UIView {
    
    lazy var label: UILabel = {
        let title = UILabel()
        title.text = ""
        title.font = Fonts.title3
        title.textColor = .label
        return title
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Editar", for: .normal)
        button.setTitleColor(.accent, for: .normal)
        button.addTarget(self, action: #selector(editSession), for: .touchUpInside)
        return button
    }()
    
    lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, editButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.body
        label.text = ""
        label.textColor = .secondaryLabel
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var title: String?{
        didSet{
            label.text = title
        }
    }
    
    
    var details: String?{
        didSet{
            detailLabel.text = details
        }
    }
    
    @objc func editSession() {
    
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategorySummary: ViewCodeProtocol {
    func addSubViews() {
        addSubview(headerStack)
        addSubview(detailLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: self.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            detailLabel.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 8),
            detailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            detailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        ])
    }
}

//
//  PaymentOption.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 18/06/25.
//

import UIKit

protocol PaymentOptionViewDelegate: AnyObject {
    func didSelect(option: PaymentOptionView)
}

final class PaymentOptionView: UIView, ViewCodeProtocol {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let radioButton = UIButton(type: .system)
    
    private(set) var title: String = ""
    weak var delegate: PaymentOptionViewDelegate?
    
    init(icon: UIImage?, title: String, isSelected: Bool) {
        super.init(frame: .zero)
        self.title = title
        
        configure(icon: icon, title: title, isSelected: isSelected)
        setup()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        
        radioButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        iconImageView.isUserInteractionEnabled = true
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        iconImageView.addGestureRecognizer(iconTap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(icon: UIImage?, title: String, isSelected: Bool) {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 32
        
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .accent
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = Fonts.body
        
        configureRadioButton(selected: isSelected)
    }
    
    private func configureRadioButton(selected: Bool) {
        radioButton.subviews.forEach { $0.removeFromSuperview() }
        
        radioButton.layer.cornerRadius = 12
        radioButton.layer.borderWidth = 2
        radioButton.layer.borderColor = UIColor.systemIndigo.cgColor
        radioButton.backgroundColor = selected ? .systemIndigo : .clear
        
        if selected {
            let innerCircle = UIView()
            innerCircle.backgroundColor = .white
            innerCircle.layer.cornerRadius = 6
            innerCircle.translatesAutoresizingMaskIntoConstraints = false
            radioButton.addSubview(innerCircle)
            NSLayoutConstraint.activate([
                innerCircle.centerXAnchor.constraint(equalTo: radioButton.centerXAnchor),
                innerCircle.centerYAnchor.constraint(equalTo: radioButton.centerYAnchor),
                innerCircle.widthAnchor.constraint(equalToConstant: 12),
                innerCircle.heightAnchor.constraint(equalToConstant: 12)
            ])
        }
    }
    
    @objc private func handleTap() {
        delegate?.didSelect(option: self)
    }
    
    func setSelected(_ selected: Bool) {
        configureRadioButton(selected: selected)
    }
        
    func addSubViews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(radioButton)
    }
    
    func setupConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            radioButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            radioButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            radioButton.widthAnchor.constraint(equalToConstant: 24),
            radioButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

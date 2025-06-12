//
//  LaundryCard.swift
//  laundry-app
//
//  Created by Gabriel Barbosa on 11/06/25.
//

import Foundation
import UIKit

class LaundryCard: UIView{
    lazy var avalibility: AvalibilityCard = {
        let view = AvalibilityCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 32
        iv.image = UIImage(named: "defaultLaundryImage")
        return iv
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = Fonts.title1
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.25
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowRadius = 2           
        label.layer.masksToBounds = false
        
        return label
    }()
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    var imageName: String = "" {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setup()        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension LaundryCard: ViewCodeProtocol {
    func addSubViews() {
        addSubview(imageView)
        addSubview(label)
        addSubview(avalibility) 
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 142),
            
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor ,constant: 16),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -16),
            
            avalibility.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 16),
            avalibility.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 12),
            avalibility.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    
}

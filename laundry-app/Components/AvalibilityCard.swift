//
//  CardLavanderia.swift
//  laundry-app
//
//  Created by Gustavo Melleu on 11/06/25.
//

import Foundation
import UIKit

protocol AvalibilityCardDelegate: AnyObject {
    func isLaundryOpen(for laundry: Laundry) -> Bool
}


class AvalibilityCard: UIView {
    
    weak var delegate: AvalibilityCardDelegate?
    var laundry: Laundry? {
        didSet {
            updateStatus()
        }
    }
    
    lazy var backGround: UIView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterial)
        let view = UIVisualEffectView(effect: blur)
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bol: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(named: "OpenCircle")
        
        //Shadow Chat
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false

        return view
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.text = "Peça agora"
        return label
    }()
    
    lazy var stack : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bol,label])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    //funcao para ver colocar a Cor de aberto ou fechado
    func updateStatus() {
        guard let laundry = laundry else { return }
        let isOpen = delegate?.isLaundryOpen(for: laundry) ?? false
        bol.backgroundColor = isOpen ? UIColor(named: "OpenCircle") : UIColor(named: "ClosedCircle")
        label.text = isOpen ? "Peça agora" : "Agende"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
}

extension AvalibilityCard: ViewCodeProtocol {
    func addSubViews() {
      addSubview(backGround)
      addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
                 backGround.heightAnchor.constraint(equalToConstant: 28),

                 backGround.topAnchor.constraint(equalTo: topAnchor),
                 backGround.leadingAnchor.constraint(equalTo: leadingAnchor),
                 backGround.bottomAnchor.constraint(equalTo: bottomAnchor),
                 
              
                 stack.centerYAnchor.constraint(equalTo: backGround.centerYAnchor),
                 stack.leadingAnchor.constraint(equalTo: backGround.leadingAnchor, constant: 8),
                 stack.trailingAnchor.constraint(equalTo: backGround.trailingAnchor, constant: -8),
                 
         
                 bol.widthAnchor.constraint(equalToConstant: 16),
                 bol.heightAnchor.constraint(equalToConstant: 16),
               ])
               
               backGround.setContentHuggingPriority(.required, for: .horizontal)
               backGround.setContentCompressionResistancePriority(.required, for: .horizontal)
    
    }
    
    
}



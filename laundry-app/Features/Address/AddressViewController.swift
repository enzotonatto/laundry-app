//
//  AddressViewController.swift
//  laundry-app
//
//  Created by Gustavo Melleu on 18/06/25.
//

import Foundation
import UIKit

class AddressViewController: UIViewController {
    
    lazy var labelAddress: UILabel = {
        let label = UILabel()
        label.text = "Preencha o endereço onde deseja que a coleta seja realizada"
        label.font = Fonts.title3
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    
    private let cep = AddressComponent()
    private let address = AddressComponent()
    private let number = AddressComponent()
    private let complement = AddressComponent()
    private let button = GradientButton()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Endereço"
        navigationItem.backButtonTitle = "Voltar"
        
        setupLayout()
        
    }
    private func setupLayout() {
        view.addSubview(labelAddress)
        view.addSubview(cep)
        view.addSubview(address)
        view.addSubview(number)
        view.addSubview(complement)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Prórximo"
        //cep
        cep.translatesAutoresizingMaskIntoConstraints = false
        cep.configure(label: "CEP*", placeholder: "00000-000")
        //address
        address.translatesAutoresizingMaskIntoConstraints = false
        address.configure(label: "Endereço*", placeholder: "Endereço")
        //number
        number.translatesAutoresizingMaskIntoConstraints = false
        number.configure(label: "Número*", placeholder: "000")
        //complement
        complement.translatesAutoresizingMaskIntoConstraints = false
        complement.configure(label: "Complemento", placeholder: "000")
        
        
        
        
        
        NSLayoutConstraint.activate([
            
            labelAddress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelAddress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelAddress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            cep.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 16),
            cep.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cep.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            address.topAnchor.constraint(equalTo: cep.bottomAnchor, constant: 16),
            address.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            address.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            number.topAnchor.constraint(equalTo: address.bottomAnchor, constant: 16),
            number.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            number.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            complement.topAnchor.constraint(equalTo: number.bottomAnchor, constant: 16),
            complement.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            complement.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -44)

            
        ])
        
        
    }
    
}

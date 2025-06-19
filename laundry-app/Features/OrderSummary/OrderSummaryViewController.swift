//
//  OrderSummaryViewController.swift
//  laundry-app
//
//  Created by Antonio Costa on 18/06/25.
//

import Foundation
import UIKit

class OrderSummaryViewController: UIViewController, UITextFieldDelegate {
    
    lazy var clothesSummary: CategorySummary = {
        let view = CategorySummary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "Peças"
        view.details = """
        2    Camisetas
        3    Meias
        10   Moletons
        """
        return view
    }()
    
    lazy var addressSummary: CategorySummary = {
        let view = CategorySummary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "Endereço"
        view.details = """
        2    Camisetas
        3    Meias
        10   Moletons
        """
        return view
    }()
    
    lazy var paymentMethodSumary: CategorySummary = {
        let view = CategorySummary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "Método de pagamento"
        view.details = """
        2    Camisetas
        3    Meias
        10   Moletons
        """
        return view
    }()
    
    lazy var schedulingSummary: CategorySummary = {
        let view = CategorySummary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "Agendamento da coleta"
        view.details = """
        2    Camisetas
        3    Meias
        10   Moletons
        """
        return view
    }()
    
    lazy var observation: ObservationTextField = {
        let obs = ObservationTextField()
        obs.translatesAutoresizingMaskIntoConstraints = false
        return obs
    }()
    
    lazy var finishOrderButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Finalizar Pedido"
        button.isShowingIcon = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Resumo do pedido"
        view.backgroundColor = .systemBackground
        observation.textField.delegate = self
        observation.textField.becomeFirstResponder()
        navigationController?.navigationBar.prefersLargeTitles = false
        setup()
    
    }

}

extension OrderSummaryViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(clothesSummary)
        view.addSubview(addressSummary)
        view.addSubview(paymentMethodSumary)
        view.addSubview(schedulingSummary)
        view.addSubview(observation)
        view.addSubview(finishOrderButton)



    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            clothesSummary.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            clothesSummary.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            clothesSummary.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            addressSummary.topAnchor.constraint(equalTo: clothesSummary.bottomAnchor, constant: 24),
            addressSummary.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addressSummary.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            paymentMethodSumary.topAnchor.constraint(equalTo: addressSummary.bottomAnchor, constant: 24),
            paymentMethodSumary.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            paymentMethodSumary.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            schedulingSummary.topAnchor.constraint(equalTo: paymentMethodSumary.bottomAnchor, constant: 24),
            schedulingSummary.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            schedulingSummary.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            observation.topAnchor.constraint(equalTo: schedulingSummary.bottomAnchor, constant: 24),
            observation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            observation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            
            finishOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -11),
            finishOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            finishOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),            
        ])
    }
}

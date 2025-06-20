//
//  OrderSummaryViewController.swift
//  laundry-app
//
//  Created by Antonio Costa on 18/06/25.
//

import Foundation
import UIKit

class OrderSummaryViewController: UIViewController, UITextFieldDelegate, CategorySummaryDelegate {
    
    lazy var dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    lazy var clothesSummary: CategorySummary = {
        let view = CategorySummary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "Peças"
        view.details = OrderFlowViewModel.shared.selectedClothes
        view.section = .clothes
        view.delegate = self
        return view
    }()

    lazy var addressSummary: CategorySummary = {
        let view = CategorySummary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "Endereço"
        view.details = OrderFlowViewModel.shared.pickupAddress
        view.section = .address
        view.delegate = self
        return view
    }()

    lazy var paymentMethodSumary: CategorySummary = {
        let view = CategorySummary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "Método de pagamento"
        view.details = OrderFlowViewModel.shared.paymentMethod
        view.section = .payment
        view.delegate = self
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
        button.addTarget(self, action: #selector(goToConfirmationVC), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Resumo do pedido"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        observation.textField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clothesSummary.details       = OrderFlowViewModel.shared.selectedClothes
        addressSummary.details       = OrderFlowViewModel.shared.pickupAddress
        paymentMethodSumary.details  = OrderFlowViewModel.shared.paymentMethod
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func goToConfirmationVC() {
        guard let laundry = OrderFlowViewModel.shared.selectedLaundry,
              let laundryId = laundry.id else {
            print("🛑 Falha: lavanderia ou ID inválido")
            return
        }

        // Valores vindos do fluxo
        let pickupAddress = OrderFlowViewModel.shared.pickupAddress
        let itemList      = OrderFlowViewModel.shared.selectedClothes
        let paymentMethod = OrderFlowViewModel.shared.paymentMethod
        let createAt      = Date()

        // 1️⃣ Salva no Core Data
        OrdersPersistence.shared.addNewOrder(
            pickupAddress: pickupAddress,
            createAt: createAt,
            itemList: itemList,
            laundryId: laundryId,
            paymentMethod: paymentMethod
        )
        
        // 2️⃣ Navega para a tela de confirmação
        navigationController?.setNavigationBarHidden(false, animated: false)
        let confirmationVC = OrderConfirmationViewController()
        navigationController?.pushViewController(confirmationVC, animated: true)
    }

    
    func categorySummaryDidTapEdit(_ section: OrderSummarySection) {
        switch section {
        case .clothes:
            // volta para ClothingSelectionViewController
            if let vc = navigationController?.viewControllers.first(where: { $0 is ClothingSelectionViewController }) {
                navigationController?.popToViewController(vc, animated: true)
            }
        case .address:
            // volta para AddressViewController
            if let vc = navigationController?.viewControllers.first(where: { $0 is AddressViewController }) {
                navigationController?.popToViewController(vc, animated: true)
            }
        case .payment:
            // volta para PaymentMethodViewController
            if let vc = navigationController?.viewControllers.first(where: { $0 is PaymentMethodViewController }) {
                navigationController?.popToViewController(vc, animated: true)
            }
        }
    }

}

extension OrderSummaryViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(clothesSummary)
        view.addSubview(addressSummary)
        view.addSubview(paymentMethodSumary)
        //view.addSubview(schedulingSummary)
        view.addSubview(observation)
        view.addSubview(finishOrderButton)
        view.addSubview(dividerLine)


    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dividerLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            clothesSummary.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            clothesSummary.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            clothesSummary.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            addressSummary.topAnchor.constraint(equalTo: clothesSummary.bottomAnchor, constant: 24),
            addressSummary.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addressSummary.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            paymentMethodSumary.topAnchor.constraint(equalTo: addressSummary.bottomAnchor, constant: 24),
            paymentMethodSumary.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            paymentMethodSumary.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
//            schedulingSummary.topAnchor.constraint(equalTo: paymentMethodSumary.bottomAnchor, constant: 24),
//            schedulingSummary.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            schedulingSummary.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            observation.topAnchor.constraint(equalTo: paymentMethodSumary.bottomAnchor, constant: 24),
            observation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            observation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            
            finishOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            finishOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            finishOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),            
        ])
    }
}

//
//  PaymentMethod.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 18/06/25.
//

import Foundation
import UIKit

class PaymentMethodViewController: UIViewController {
    
    private let progress = StepProgressView()
    
    private var paymentOptions: [PaymentOptionView] = []
    private var selectedPaymentMethod: String = "Pix"
    
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Selecione seu método de pagamento"
        label.numberOfLines = 0
        label.font = Fonts.title3
        label.textColor = .label
        
        return label
    }()
    
    lazy var dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private let stackView = UIStackView()
    
    lazy var nextButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Próximo"
        button.addTarget(self, action: #selector(goToOrderSummaryVC), for: .touchUpInside)
        button.isShowingIcon = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Método de pagamento"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        
        setupStackView()
        setupPaymentOptions()
        setup()
    }
    
    @objc func goToOrderSummaryVC() {
        OrderFlowViewModel.shared.paymentMethod = selectedPaymentMethod
        navigationController?.setNavigationBarHidden(false, animated: false)
        let orderSummaryVC = OrderSummaryViewController()
        navigationController?.pushViewController(orderSummaryVC, animated: true)
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        ])
    }
    
    private func setupPaymentOptions() {
        let moneyOption = PaymentOptionView(icon: UIImage(named: "moneyLarge"), title: "Dinheiro", isSelected: false)
        let cardOption = PaymentOptionView(icon: UIImage(named: "cardLarge"), title: "Cartão", isSelected: false)
        let pixOption = PaymentOptionView(icon: UIImage(named: "pixLarge"), title: "Pix", isSelected: true)
        
        [moneyOption, cardOption, pixOption].forEach {
            $0.delegate = self
            paymentOptions.append($0)
            stackView.addArrangedSubview($0)
        }
        
        selectedPaymentMethod = "Pix"
    }



}

extension PaymentMethodViewController: PaymentOptionViewDelegate {
    func didSelect(option: PaymentOptionView) {
        for payment in paymentOptions {
            payment.setSelected(payment === option)
        }
        selectedPaymentMethod = option.title
    }
}


extension PaymentMethodViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(dividerLine)
        view.addSubview(instructionsLabel)
        view.addSubview(nextButton)
        view.addSubview(stackView)
        view.addSubview(progress)
        
        
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            progress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            progress.heightAnchor.constraint(equalToConstant: 4),
            dividerLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            instructionsLabel.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 16),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        progress.numberOfSteps = 4
        progress.setStep(3, animated: false)
    }
    func avançouParaPasso(_ passo: Int) {
        progress.setStep(passo, animated: true)
        
        
    }
}

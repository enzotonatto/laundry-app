//
//  PaymentMethod.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 18/06/25.
//

import Foundation
import UIKit

final class PaymentMethodViewController: UIViewController {
    private var paymentOptions: [PaymentOptionView] = []
    private var selectedPaymentMethod: String = ""

    private lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Selecione seu método de pagamento"
        label.numberOfLines = 0
        label.font = Fonts.title3
        label.textColor = .label
        return label
    }()

    private lazy var dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()

    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private lazy var nextButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Próximo"
        button.isShowingIcon = true
        button.isActive = false
        button.addTarget(self, action: #selector(goToSchedulingVC), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Método de pagamento"
        navigationItem.backButtonTitle = "Voltar"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backButtonTitle = "Voltar"
        setupStackView()
        setupPaymentOptions()
        setup()
    }
    
    @objc func goToSchedulingVC() {
        OrderFlowViewModel.shared.paymentMethod = selectedPaymentMethod
        navigationController?.setNavigationBarHidden(false, animated: false)
        let schedulingVC = CollectionSchedullingViewController()
        navigationController?.pushViewController(schedulingVC, animated: true)
    }

    private func setupStackView() {
        view.addSubview(dividerLine)
        view.addSubview(instructionsLabel)
        view.addSubview(stackView)
        view.addSubview(nextButton)
    }

    private func setupPaymentOptions() {
        let moneyOption = PaymentOptionView(icon: UIImage(named: "moneyLarge"), title: "Dinheiro", isSelected: false)
        let cardOption  = PaymentOptionView(icon: UIImage(named: "cardLarge"),  title: "Cartão",    isSelected: false)
        let pixOption   = PaymentOptionView(icon: UIImage(named: "pixLarge"),   title: "Pix",       isSelected: false)

        [moneyOption, cardOption, pixOption].forEach {
            $0.delegate = self
            paymentOptions.append($0)
            stackView.addArrangedSubview($0)
        }
    }
}

extension PaymentMethodViewController: PaymentOptionViewDelegate {
    func didSelect(option: PaymentOptionView) {
        for payment in paymentOptions {
            payment.setSelected(payment === option)
        }
        selectedPaymentMethod = option.title
        nextButton.isActive = true
    }
}

extension PaymentMethodViewController: ViewCodeProtocol {
    func addSubViews() {}

    func setupConstraints() {
        NSLayoutConstraint.activate([
            dividerLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 0.5),

            instructionsLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 16),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            stackView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

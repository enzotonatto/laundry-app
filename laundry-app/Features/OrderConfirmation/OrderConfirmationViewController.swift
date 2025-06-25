//
//  OrderConfirmationViewController.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 18/06/25.
//

import Foundation
import UIKit

class OrderConfirmationViewController: UIViewController {
    
    lazy var imageBubble: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bubble"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var tittleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pedido finalizado!"
        label.font = Fonts.title2
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pressione o botão abaixo para enviar sua solicitação à lavanderia."
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = Fonts.body
        return label
    }()
    
    lazy var whatsAppButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Ir para o WhatsApp"
        button.isShowingIcon = true
        button.isActive = true
        button.addTarget(self, action: #selector(openWhatsApp), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = UIBarButtonItem(
            title: "Feito",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        doneButton.tintColor = .accent
        
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = doneButton
        
        setup()
    }
    
    @objc func doneButtonTapped() {
        OrdersPersistence.shared.printAllOrders()
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func openWhatsApp() {
        guard let laundry = OrderFlowViewModel.shared.selectedLaundry else { return }

        var message = """
        🧺 *Novo Pedido de Lavanderia*

        🏢 Lavanderia: \(laundry.name ?? "N/A")

        👕 Peças:
        \(OrderFlowViewModel.shared.selectedClothes)

        📍 Endereço de coleta:
        \(OrderFlowViewModel.shared.pickupAddress)
        
        ⏰ Agendamento de coleta:
        \(OrderFlowViewModel.shared.selectedDayMonth)/\(OrderFlowViewModel.shared.selectedMonth) - \(OrderFlowViewModel.shared.selectedDayWeek)
        \(OrderFlowViewModel.shared.selectedTimeStart) - \(OrderFlowViewModel.shared.selectedTimeEnd)
        
        💳 Método de pagamento:
        \(OrderFlowViewModel.shared.paymentMethod)

        📅 Criado em:
        \(DateFormatter
            .localizedString(from: Date(), dateStyle: .short, timeStyle: .short))
        """

        if let obs = OrderFlowViewModel.shared.observation {
            message += "\n\n💬 Observação:\n\(obs)"
        }

        let phone     = laundry.phoneNumber ?? ""
        let encoded   = message
                          .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://wa.me/\(phone)?text=\(encoded)"

        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }



}

extension OrderConfirmationViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(imageBubble)
        view.addSubview(tittleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(whatsAppButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBubble.widthAnchor.constraint(equalToConstant: 176),
            imageBubble.heightAnchor.constraint(equalToConstant: 176),
            imageBubble.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            imageBubble.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tittleLabel.topAnchor.constraint(equalTo: imageBubble.bottomAnchor, constant: 32),
            tittleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: tittleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            whatsAppButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            whatsAppButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            whatsAppButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),

        ])
    }
    
    
}

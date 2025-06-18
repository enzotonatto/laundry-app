//
//  LaundryDetailViewController.swift
//  laundry-app
//
//  Created by Gustavo Melleu on 15/06/25.
//

import UIKit

class LaundryDetailViewController: UIViewController {
    private let laundry: Laundry
    
    lazy var returnButton: ReturnButton = {
        let button = ReturnButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var laundryImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "laundryImageBanner")
        return image
    }()
    
    lazy var availabilityCard: AvalibilityCard = {
        var card = AvalibilityCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    lazy var detailsContainer: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    lazy var laundryName: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = laundry.name
        title.font = Fonts.title1
        return title
    }()
    
    lazy var laundryDescription: UILabel = {
        var label = UILabel()
        label.text = laundry.details
        label.font = UIFont(name: "SFProText-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var laundryStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [laundryName, laundryDescription])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var adressInfoRow: InfoRow = {
        let icon = UIImage(systemName: "storefront.circle.fill")!
        return InfoRow(icon: icon, title: "ENDEREÇO", text: laundry.address ?? "Sem endereço")
    }()
    
    lazy var hoursInfoRow: InfoRow = {
        let icon = UIImage(named: "customStopwatch")!
        
        let hoursText: String
        if let open = laundry.openHour, let close = laundry.closeHour {
          let formatter = DateFormatter()
          formatter.dateFormat = "H:mm"
          formatter.locale = Locale.current
          let openStr  = formatter.string(from: open)
          let closeStr = formatter.string(from: close)
          hoursText = "\(openStr) às \(closeStr)"
        } else {
          hoursText = "Horário indisponível"
        }
        
        return InfoRow(icon: icon, title: "HORÁRIOS", text: hoursText)
    }()
    
    lazy var paymentInfoRow: InfoRow = {
        let icon = UIImage(systemName: "creditcard.circle.fill")!
        
        let paymentIcons: [UIImage] = laundry.paymentMethod!
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { PaymentMethod(rawValue: $0) }
            .compactMap { UIImage(named: $0.imageName) }

        
        return InfoRow(icon: icon, title: "MÉTODOS DE PAGAMENTO", images: paymentIcons)
    }()
    
    lazy var infoStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [adressInfoRow, hoursInfoRow, paymentInfoRow])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    lazy var startOrderButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Iniciar Pedido"
        button.isShowingIcon = false
        button.setGradientColors([.startGradient, .endGradient])
        button.addTarget(self, action: #selector(goToClothingSelectionVC), for: .touchUpInside)
        return button
    }()
    
    init(laundry: Laundry) {
        self.laundry = laundry
        super.init(nibName: nil, bundle: nil)
        returnButton.addTarget(self, action: #selector(returnToLaundryVC), for:.touchUpInside)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationItem.backButtonTitle = "Voltar"
        view.backgroundColor = .systemBackground
        setup()
    }
    
    @objc func returnToLaundryVC() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func goToClothingSelectionVC() {
    
        navigationController?.setNavigationBarHidden(false, animated: false)
        let clothingSelectionVC = ClothingSelectionViewController()
        navigationController?.pushViewController(clothingSelectionVC, animated: true)
    }
    
}

extension LaundryDetailViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(laundryImage)
        view.addSubview(returnButton)
        view.addSubview(availabilityCard)
        view.addSubview(detailsContainer)
        view.addSubview(laundryStack)
        view.addSubview(infoStack)
        view.addSubview(startOrderButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            returnButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            laundryImage.topAnchor.constraint(equalTo: view.topAnchor),
            laundryImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            laundryImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            laundryImage.heightAnchor.constraint(equalToConstant: 328),
            
            availabilityCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            availabilityCard.bottomAnchor.constraint(equalTo: detailsContainer.topAnchor, constant: -16),
            
            detailsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsContainer.topAnchor.constraint(equalTo: laundryImage.bottomAnchor, constant: -44),
            
            laundryStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            laundryStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            laundryStack.topAnchor.constraint(equalTo: detailsContainer.topAnchor, constant: 24),
            
            infoStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            infoStack.topAnchor.constraint(equalTo: laundryStack.bottomAnchor, constant: 16),
            
            
            
            startOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            startOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
}

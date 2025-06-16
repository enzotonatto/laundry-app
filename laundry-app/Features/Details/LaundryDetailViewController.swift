//
//  LaundryDetailViewController.swift
//  laundry-app
//
//  Created by Gustavo Melleu on 15/06/25.
//

import UIKit

class LaundryDetailViewController: UIViewController {
    private let laundry: Laundry
    
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
        //if let text = laundry.text
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
    
    lazy var startOrderButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Iniciar Pedido"
        button.isShowingIcon = false
        button.setGradientColors([.accent, .endGradient])
        return button
    }()
    

    init(laundry: Laundry) {
        self.laundry = laundry
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }

}

extension LaundryDetailViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(laundryImage)
        view.addSubview(availabilityCard)
        view.addSubview(detailsContainer)
        view.addSubview(laundryStack)
        view.addSubview(startOrderButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
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
        
        
        
        startOrderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        startOrderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        startOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        
        ])
    }
    
    
}

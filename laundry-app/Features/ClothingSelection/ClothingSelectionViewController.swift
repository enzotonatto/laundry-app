//
//  ClothingSelectionViewController.swift
//  laundry-app
//
//  Created by Gabriel Barbosa on 17/06/25.
//

import UIKit

class ClothingSelectionViewController: UIViewController {

    lazy var nextButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Próximo"
        button.isShowingIcon = true
        
        return button
    }()
    
    lazy var dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        return view
    }()
    
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicione todas as peças que você deseja lavar:"
        label.numberOfLines = 0
        label.font = Fonts.title2
        label.textColor = .label
        
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Peças"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setup()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Re-esconde a navigation bar quando voltar para LaundryDetail
        if isMovingFromParent {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
}

extension ClothingSelectionViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(dividerLine)
        view.addSubview(instructionsLabel)
        view.addSubview(nextButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            dividerLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dividerLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            instructionsLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 16),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
        ])
    }
    
    
}

//
//  LaundryDetailViewController.swift
//  laundry-app
//
//  Created by Gustavo Melleu on 15/06/25.
//

import UIKit

class LaundryDetailViewController: UIViewController {
    private let laundry: Laundry
    
    // MARK: - Init
    init(laundry: Laundry) {
        self.laundry = laundry
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let hoursLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // … adicione mais views (mapa, fotos, opções de agendamento, etc.)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Detalhes"
        
        setupViews()
        configureWithLaundry()
    }

    
    private func setupViews() {
        view.addSubview(nameLabel)
        view.addSubview(hoursLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            hoursLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            hoursLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            hoursLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
    }
    
    private func configureWithLaundry() {
        nameLabel.text = laundry.name
        if let open = laundry.openHour, let close = laundry.closeHour {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            hoursLabel.text = "Aberto de \(formatter.string(from: open)) às \(formatter.string(from: close))"
        } else {
            hoursLabel.text = "Horário indisponível"
        }
        // preencha o resto das infos…
    }
}

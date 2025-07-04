//
//  LaundryCardCell.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 11/06/25.
//

import UIKit

class LaundryCardCell: UICollectionViewCell {
    static let reuseIdentifier = "LaundryCardCell"
    private let card = LaundryCard()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with laundry: Laundry , delegate: AvalibilityCardDelegate?) {
        card.title = laundry.name ?? ""
        
        card.imageName = laundry.image ?? "laundryImage"
        
        card.avalibility.delegate = delegate
        card.avalibility.laundry = laundry
    }

    }

extension LaundryCardCell: ViewCodeProtocol {
    func addSubViews() {
        contentView.addSubview(card)
    }

    func setupConstraints() {
        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

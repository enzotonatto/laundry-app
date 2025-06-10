//
//  ViewCodeProtocol.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 10/06/25.
//

import Foundation

protocol ViewCodeProtocol {
    func addSubViews()
    func setupConstraints()
    func setup()
}

extension ViewCodeProtocol {
    func setup() {
        addSubViews()
        setupConstraints()
    }
}

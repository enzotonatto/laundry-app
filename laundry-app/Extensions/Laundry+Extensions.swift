//
//  Untitled.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 25/06/25.
//

import Foundation

extension Laundry {
    var supportedPaymentMethods: [PaymentMethod] {
        return paymentMethod?
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .compactMap { PaymentMethod(rawValue: $0) }
        ?? []
    }
}

//
//  PaymentMethod.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 16/06/25.
//

import Foundation

enum PaymentMethod: String, Codable, CaseIterable {
    case pix, card, money
    
    var imageName: String { rawValue }
    
    var displayName: String {
        switch self {
        case .pix:   return "Pix"
        case .card:  return "Cartão"
        case .money: return "Dinheiro"
        }
    }
}


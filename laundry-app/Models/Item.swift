//
//  Item.swift
//  laundry-app
//
//  Created by Gustavo Melleu on 17/06/25.
//

import Foundation
import UIKit

enum Item: String, Codable , CaseIterable {
    case shirt = "shirt"
    case jacket = "jacket"
    case pants = "pants"
    case suit = "suit"
    case bedsheet = "bedsheet"
}

extension Item {
    var displayName: String {
        switch self {
        case .shirt: return "Camisa"
        case .jacket: return "Jaqueta"
        case .pants: return "Calça"
        case .suit: return "Terno"
        case .bedsheet: return "Lençol"
        }
    }
}

// MARK: - Transformar [Item: Int] em String
func formatItemList(_ quantities: [Item: Int]) -> String {
    return quantities
        .filter { $0.value > 0 }
        .map { "\($0.key.rawValue):\($0.value)" }
        .joined(separator: ",")
}

// MARK: - Transformar String em [Item: Int]
func parseItemList(_ itemList: String) -> [Item: Int] {
    var result: [Item: Int] = [:]
    
    let pairs = itemList.split(separator: ",")
    for pair in pairs {
        let components = pair.split(separator: ":")
        guard components.count == 2 else { continue }
        
        let key = components[0].trimmingCharacters(in: .whitespaces)
        let value = components[1].trimmingCharacters(in: .whitespaces)
        
        if let item = Item(rawValue: key),
           let quantity = Int(value) {
            result[item] = quantity
        }
    }
    
    return result
}

//
//  Untitled.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 19/06/25.
//

import Foundation

class OrderFlowViewModel {
    static let shared = OrderFlowViewModel()
    
    var selectedLaundry: Laundry?
    var selectedClothes: String = ""
    var pickupAddress: String = ""
    var paymentMethod: String = ""
    
    
    func clear() {
        selectedLaundry = nil
        selectedClothes = ""
        pickupAddress = ""
        paymentMethod = ""
    }
}

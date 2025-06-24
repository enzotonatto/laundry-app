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
    var observation: String? = ""
    var selectedDayMonth: String = ""
    var selectedMonth: String = ""
    var selectedDayWeek: String = ""
    var selectedTimeStart: String = ""
    var selectedTimeEnd: String = ""
    var fullScheduling: String = ""
    
    
    func clear() {
        selectedLaundry = nil
        selectedClothes = ""
        pickupAddress = ""
        paymentMethod = ""
        observation = ""
        selectedDayMonth = ""
        selectedDayWeek = ""
        selectedTimeStart = ""
        selectedTimeEnd = ""
    }
}

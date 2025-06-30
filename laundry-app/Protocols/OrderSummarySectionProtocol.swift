//
//  Untitled.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 19/06/25.
//

enum OrderSummarySection {
    case clothes, address, payment, delivery
}

protocol CategorySummaryDelegate: AnyObject {
    func categorySummaryDidTapEdit(_ section: OrderSummarySection)
}

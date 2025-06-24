//
//  LaundryPersistenceProtocol.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 10/06/25.
//

import Foundation

protocol LaundryPersistenceProtocol {
    func addNewLaundry(name: String, address: String, latitude: Double,
                       longitude: Double, openHour: Date, closeHour: Date,
                       details: String, image: String, phoneNumber: String,
                       paymentMethod: String, imageBanner: String)
    func getAllLaundries() -> [Laundry]
    func getLaundry(by id: UUID) -> Laundry?

}

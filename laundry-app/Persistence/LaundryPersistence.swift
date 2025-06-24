//
//  LaundryPersistence.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 10/06/25.
//

import Foundation
import CoreData

final class LaundryPersistence {
    
    static var shared = LaundryPersistence()
    
    var context: NSManagedObjectContext?
    
}

extension LaundryPersistence: LaundryPersistenceProtocol {
    func addNewLaundry(name: String, address: String, latitude: Double, longitude: Double, openHour: Date, closeHour: Date, details: String, image: String, phoneNumber: String, paymentMethod: String, imageBanner: String) {
        guard let context else { return }
        
        let newLaundry = Laundry(context: context)
        newLaundry.id = UUID()
        newLaundry.name = name
        newLaundry.address = address
        newLaundry.latitude = latitude
        newLaundry.longitude = longitude
        newLaundry.openHour = openHour
        newLaundry.closeHour = closeHour
        newLaundry.details = details
        newLaundry.image = image
        newLaundry.phoneNumber = phoneNumber
        newLaundry.paymentMethod = paymentMethod
        newLaundry.imageBanner = imageBanner
        
        save()

    }
    
    func getAllLaundries() -> [Laundry] {
        guard let context else { return [] }
        
        var result: [Laundry] = []
        
        do {
            result = try context.fetch(Laundry.fetchRequest())
        } catch { print(error) }
        
        return result
    }
    
    func getLaundry(by id: UUID) -> Laundry? {
        guard let context else { return nil }
        
        do {
            let fetchRequest: NSFetchRequest<Laundry> = Laundry.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
            return try context.fetch(fetchRequest).first
        } catch { print(error) }
        
        return nil
    }
    
    func mockData() {
        let laundries = getAllLaundries()
        
        if laundries.isEmpty {
            let now = Date()
            let calendar = Calendar.current

            addNewLaundry(
                name: "iWash",
                address: "Rua das Flores, 100",
                latitude: -23.5505,
                longitude: -46.6333,
                openHour: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: now)!,
                closeHour: calendar.date(bySettingHour: 20, minute: 0, second: 0, of: now)!,
                details: "Self-service 24h com máquina rápida",
                image: "iWashImage",
                phoneNumber: "5551984229066",
                paymentMethod: "pix",
                imageBanner: "iWashImage"
            )

            addNewLaundry(
                name: "Gumgum Lavanderias",
                address: "Av. Paulista, 2000",
                latitude: -23.5610,
                longitude: -46.6560,
                openHour: calendar.date(bySettingHour: 7, minute: 30, second: 0, of: now)!,
                closeHour: calendar.date(bySettingHour: 22, minute: 0, second: 0, of: now)!,
                details: "Lavagem premium e entrega express",
                image: "laundryImage",
                phoneNumber: "5551983385200",
                paymentMethod: "pix, money",
                imageBanner: "laundryImageBanner"

            )

            addNewLaundry(
                name: "iLaundery",
                address: "Rua Augusta, 500",
                latitude: -23.5615,
                longitude: -46.6550,
                openHour: calendar.date(bySettingHour: 9, minute: 0, second: 0, of: now)!,
                closeHour: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: now)!,
                details: "Atendimento expresso e eco-friendly",
                image: "iLaunderyImage",
                phoneNumber: "5551998292204",
                paymentMethod: "pix, money, card",
                imageBanner: "iLaunderyImage"

            )

            addNewLaundry(
                name: "Lavanderia do Gabriel",
                address: "R. dos Imigrantes, 75",
                latitude: -23.6280,
                longitude: -46.7120,
                openHour: calendar.date(bySettingHour: 8, minute: 0, second: 0, of: now)!,
                closeHour: calendar.date(bySettingHour: 19, minute: 0, second: 0, of: now)!,
                details: "Entrega grátis em até 24h",
                image: "GabsImage",
                phoneNumber: "5551996644448",
                paymentMethod: "pix",
                imageBanner: "GabsImage"

            )
            
            save()
        }
    }
    
    func save() {
        do {
            try context?.save()
        } catch { print(error) }
    }
    
    
}

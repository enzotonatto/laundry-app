import Foundation
import CoreData

final class OrdersPersistence {
    static let shared = OrdersPersistence()
    
    var context: NSManagedObjectContext?
}

extension OrdersPersistence {
    func addNewOrder(
            pickupAddress: String,
            createAt: Date,
            itemList: String,
            laundryId: UUID,
            paymentMethod: String,
            observation: String? = nil
        ) {
            guard let context else { return }
            
            let newOrder = Order(context: context)
            newOrder.id            = UUID()
            newOrder.pickupAddress = pickupAddress
            newOrder.createAt      = createAt
            newOrder.itemList      = itemList
            newOrder.laundry       = laundryId
            newOrder.paymentMethod = paymentMethod
            newOrder.observation   = observation
            
            save()
        }
    
    func getAllOrders() -> [Order] {
        guard let context else { return [] }
        do {
            return try context.fetch(Order.fetchRequest())
        } catch {
            print(error)
            return []
        }
    }
    
    func printAllOrders() {
            for order in getAllOrders() {
                print("""
                ----
                ID: \(order.id?.uuidString ?? "nil")
                Pickup Address: \(order.pickupAddress ?? "nil")
                Created At: \(order.createAt ?? Date())
                Item List: \(order.itemList ?? "nil")
                Laundry ID: \(order.laundry?.uuidString ?? "nil")
                Payment Method: \(order.paymentMethod ?? "nil")
                Observation: \(order.observation ?? "")
                ----
                """)
            }
        }
    
    func save() {
        do {
            try context?.save()
        } catch {
            print(error)
        }
    }
}

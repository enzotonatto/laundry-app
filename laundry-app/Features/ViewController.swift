//
//  ViewController.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 08/06/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let persistence = LaundryPersistence.shared
        persistence.context = viewContext

        persistence.mockData()
        let laundries = persistence.getAllLaundries()
        
        for laundry in laundries {
            print(laundry.name)
        }
    }
}


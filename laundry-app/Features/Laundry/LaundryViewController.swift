//
//  LaundryViewController.swift
//  laundry-app
//
//  Created by Antonio Costa on 11/06/25.
//

import Foundation
import UIKit

class LaundryViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        return searchController
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lavanderias"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
    }
    
}

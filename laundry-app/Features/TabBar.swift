//
//  ViewController.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 08/06/25.
//

import UIKit

class TabBar: UITabBarController {
    
    lazy var laundryTabBar: UINavigationController = {
        let title = "Lavanderias"
        let image = UIImage(systemName: "washer.fill")
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: image)
        
        let rootViewController = LaundryViewController()
        rootViewController.tabBarItem = tabItem
        
        let navController = UINavigationController(rootViewController: rootViewController)
        return navController
    }()
    
    lazy var ordersTabBar: UINavigationController = {
        let title = "Pedidos"
        let image = UIImage(systemName: "text.page.fill")
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: image)
        
        let rootViewController = OrdersViewController()
        rootViewController.tabBarItem = tabItem
        
        let navController = UINavigationController(rootViewController: rootViewController)
        return navController
    }()
    
    lazy var profileTabBar: UINavigationController = {
        let title = "Perfil"
        let image = UIImage(systemName: "person.fill")
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: image)
        
        let rootViewController = ProfileViewController()
        rootViewController.tabBarItem = tabItem
        
        let navController = UINavigationController(rootViewController: rootViewController)
        return navController
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [laundryTabBar, ordersTabBar, profileTabBar]
        
        let apparence = UITabBarAppearance()
        apparence.configureWithOpaqueBackground()
        apparence.backgroundColor = .white
        apparence.shadowColor = .lightGray
        apparence.shadowImage = nil
        tabBar.standardAppearance = apparence
        tabBar.scrollEdgeAppearance = apparence
        


    }
}


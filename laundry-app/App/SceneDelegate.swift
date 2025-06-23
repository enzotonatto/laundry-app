//
//  SceneDelegate.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 08/06/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 1) Pega o contexto do Core Data que você disse no AppDelegate
        let context = (UIApplication.shared.delegate as! AppDelegate)
                      .persistentContainer.viewContext
        
        // 2) Injeta esse contexto nas suas classes de persistência
        OrdersPersistence.shared.context = context
        LaundryPersistence.shared.context = context
        
        // 3) Cria sua UI normalmente
        let laundryVC = CollectionSchedullingViewController()
        let nav = UINavigationController(rootViewController: laundryVC)
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = nav
        self.window = window
        window.makeKeyAndVisible()
    }
    
    // As próximas funções devem estar *fora* do willConnectTo!
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // ...
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // ...
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // ...
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // ...
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // ...
    }
}

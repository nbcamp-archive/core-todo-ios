//
//  AppCoordinator.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-19.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator]
    
    let window: UIWindow
    
    init(window: UIWindow) {
        
        self.navigationController = UINavigationController()
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        
        self.childCoordinators = [Coordinator]()
        
        self.window = window
        
    }
    
    func start() {
        
        window.rootViewController = navigationController
        
        window.backgroundColor = .white
        
        let coordinator = HomeViewCoordinator(navigationController: navigationController)
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
        
        window.makeKeyAndVisible()
        
    }
    
}

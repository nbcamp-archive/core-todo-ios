//
//  HomeViewCoordinator.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-19.
//

import UIKit

class HomeViewCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator]
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        self.childCoordinators = [Coordinator]()
    }
    
    func start() {
        
        let viewController = HomeViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

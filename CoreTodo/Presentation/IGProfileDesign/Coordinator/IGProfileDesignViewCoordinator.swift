//
//  IGProfileDesignViewCoordinator.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-21.
//

import UIKit

class IGProfileDesignViewCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator]
    
    weak var parentCoordinator: HomeViewCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [Coordinator]()
    }
    
    func start() {
        let viewController = IGProfileDesignViewController()
        viewController.coordinator = self
        
        navigationController.isNavigationBarHidden = false
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.tintColor = .black
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func finish() {
        parentCoordinator?.childCoordinatorDidFinish(self)
    }
    
}

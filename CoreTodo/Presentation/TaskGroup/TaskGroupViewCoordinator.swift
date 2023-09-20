//
//  TaskGroupViewCoordinator.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-20.
//

import UIKit

class TaskGroupViewCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [Coordinator]()
    }
    
    func start() {
        let viewController = TaskGroupViewController()
        viewController.coordinator = self
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}

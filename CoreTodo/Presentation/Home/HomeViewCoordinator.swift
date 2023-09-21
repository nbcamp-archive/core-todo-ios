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
        
        navigationController.isNavigationBarHidden = false
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.tintColor = .black
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func toTaskView() {
        let coordinator = TaskGroupViewCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
    
    func toCompleteView() {
        let coordinator = CompleteGroupViewCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
    
    func toIGProfileDesignView() {
        let coordinator = IGProfileDesignViewCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
    
    func childCoordinatorDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}

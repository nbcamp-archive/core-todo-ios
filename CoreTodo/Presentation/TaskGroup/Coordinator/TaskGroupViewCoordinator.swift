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
    
    weak var parentCoordinator: HomeViewCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [Coordinator]()
    }
    
    func start() {
        let viewController = TaskGroupViewController()
        viewController.coordinator = self
        
        let coreDataManager = CoreDataManager.shared
        let viewModel = TaskViewModel(coreDataManager: coreDataManager)
        viewController.viewModel = viewModel
        
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func end() {
        parentCoordinator?.childCoordinatorDidFinish(self)
    }
    
}

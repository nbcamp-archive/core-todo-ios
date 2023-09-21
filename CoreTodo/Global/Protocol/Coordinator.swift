//
//  Coordinator.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-14.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    
}

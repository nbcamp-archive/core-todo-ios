//
//  Coordinator.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-14.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

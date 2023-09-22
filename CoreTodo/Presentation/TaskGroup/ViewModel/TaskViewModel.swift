//
//  TaskViewModel.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-21.
//

import CoreData
import Foundation

class TaskViewModel {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func createTask(title: String) {
        let task = Task(context: coreDataManager.context)
        
        task.id = UUID()
        task.modifyDate = Date()
        task.createDate = Date()
        task.isCompleted = false
        task.title = title
        
        coreDataManager.saveContext()
    }
    
    func deleteTask(at index: Int) {
        let tasks = loadTask()
        
        if index < tasks.count {
            let task = tasks[index]
            coreDataManager.context.delete(task)
            coreDataManager.saveContext()
        }
    }
    
    func updateTask(_ task: Task) {
        coreDataManager.saveContext()
    }
    
    func loadTask() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try coreDataManager.context.fetch(request)
        } catch {
            print("Failed to fetch task: \(error)")
            return []
        }
    }
    
    func loadCompletedTask() -> [Task] {
        let tasks = loadTask()
        return tasks.filter { $0.isCompleted }
    }
    
    func numberOfTask() -> Int {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try coreDataManager.context.count(for: request)
        } catch {
            print("Failed to counting tasks: \(error)")
            return 0
        }
    }
    
}

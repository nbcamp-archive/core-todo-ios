//
//  CoreDataManager.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-21.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let dataModelName: String = "CoreTodo"
    
    lazy var context = appDelegate.persistentContainer.viewContext
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("저장 완료됨")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

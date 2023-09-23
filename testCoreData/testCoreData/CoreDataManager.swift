//
//  CoreDataManager.swift
//  testCoreData
//
//  Created by Jack Lee on 2023/09/23.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading store failed \(error)")
            }
        }
        return container
    }()
    
    func createEmployee(name: String) -> Employee? {
        let context = persistentContainer.viewContext
        // NSManagedObject
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        employee.name = name
        
        do {
            try context.save()
            return employee
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        return nil
    }
    
    func fetchEmployee() -> [Employee]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        
        do {
            let employees = try context.fetch(fetchRequest)
            return employees
        } catch let fetchError {
            print("FetchError: \(fetchError)")
        }
        
        return nil
    }
    
    func fetchEmployee(withName name: String) -> Employee? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let employee = try context.fetch(fetchRequest)
            return employee.first
        } catch let fetchError {
            print("FetchError: \(fetchError)")
        }
        
        return nil
    }
    
    func updateEmployee(employee: Employee) {
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let updateError {
            print("Update Error \(updateError)")
        }
    }
    
    func deleteEmployee(employee: Employee) {
        let context = persistentContainer.viewContext
        context.delete(employee)
        
        do {
            try context.save()
        } catch let saveError {
            print("Save Error: \(saveError)")
        }
    }
}

//
//  ViewController.swift
//  testCoreData
//
//  Created by Jack Lee on 2023/09/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        demoCoreData()
        
    }
    
    func demoCoreData() {
        //create
        guard let newEmployee = CoreDataManager.shared.createEmployee(name: "Jack") else { return }
        print(newEmployee)
        
        //read
        guard let employees = CoreDataManager.shared.fetchEmployee() else { return }
        guard let employee = CoreDataManager.shared.fetchEmployee(withName: "Jack") else { return }
        // 이건 무슨 코드지?
        _ = employees.map{ print($0.name ?? "") }
        
        //update
        employee.name = "Steve"
        CoreDataManager.shared.updateEmployee(employee: employee)
        guard let updatedEmployee = CoreDataManager.shared.fetchEmployee(withName: "Steve") else { return }
        print("Updated Employee: \(updatedEmployee)")
        
        //delete
        CoreDataManager.shared.deleteEmployee(employee: updatedEmployee)
        CoreDataManager.shared.deleteEmployee(employee: newEmployee)
        
        print("number of Employees \(employees.count)")
    }


}


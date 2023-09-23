//
//  TestViewController.swift
//  testCoreData
//
//  Created by Jack Lee on 2023/09/23.
//

import UIKit

class TestViewController: UIViewController {
    
    let plusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "minus")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let employeeLabel: UILabel = {
        let label = UILabel()
        label.text = "Employees"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        [plusButton, minusButton, employeeLabel, countLabel].forEach{ view.addSubview($0) }
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            minusButton.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            employeeLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            employeeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: employeeLabel.bottomAnchor, constant: 10),
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    @objc func plusButtonTapped() {
        print("플러스 버튼이 눌렸습니다.")
        CoreDataManager.shared.createEmployee(name: "Jack")
        updateCount()
    }
    
    @objc func minusButtonTapped() {
        print("마이너스 버튼이 눌렸습니다.")
        guard let employees = CoreDataManager.shared.fetchEmployee() else { return }
        // 이건 어떻게 사용되는거지?
        guard let employee = employees.last else { return }
        CoreDataManager.shared.deleteEmployee(employee: employee)
        updateCount()
    }
    
    func updateCount() {
        guard let employees = CoreDataManager.shared.fetchEmployee() else { return }
        countLabel.text = String(employees.count)
    }
}

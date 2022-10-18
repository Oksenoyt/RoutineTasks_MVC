//
//  NewItemViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 10.07.2022.
//

import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var itemColorStackButton: [UIButton]!
    @IBOutlet weak var createButton: UIButton!
    
    let date = DateManager()
    var delegate:NewItemViewControllerDelegate!
    var tasks: [Task] = []
    private var color = "#c49dcc"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 30
        createButton.layer.cornerRadius = 15
        setTextField()
        for itemColorView in itemColorStackButton {
            itemColorView.layer.cornerRadius = 15
        }
        setBorderButton(tagButton: 0)
    }
    
    @IBAction func getColor(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            color = "#c49dcc"
            setBorderButton(tagButton: 0)
        case 1:
            color = "#bfd4d5"
            setBorderButton(tagButton: 1)
        case 2:
            color = "#b096e4"
            setBorderButton(tagButton: 2)
        case 3:
            color = "#a8eabc"
            setBorderButton(tagButton: 3)
        default:
            color = "#edc6e0"
            setBorderButton(tagButton: 4)
        }
    }
    
    @IBAction func createButton(_ sender: UIButton) {
        let currentDate = date.getDateString(dayBefore: 0)
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(with: "Заполните название задачи")
            return
        }
        guard checkUniqueName(nameNewTask: name) == true else { return }
        
        StorageManager.shared.createTask(
            taskName: name,
            color: color,
            date: currentDate
        ) { task in delegate.addNewTask(task: task) }
        
        dismiss(animated: true)
    }
    
    private func setTextField() {
        nameTextField.layer.masksToBounds = true
        nameTextField.layer.cornerRadius = 30
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.becomeFirstResponder()
        nameTextField.returnKeyType = UIReturnKeyType.done ///????
        //       nameTextField.delegate = self
    }
    
    private func setBorderButton(tagButton: Int) {
        for itemColorView in itemColorStackButton {
            itemColorView.layer.borderWidth = 0
        }
        itemColorStackButton[tagButton].layer.borderWidth = 3.0
    }
    
    private func checkUniqueName(nameNewTask: String) -> Bool {
        for task in tasks {
            if task.title == nameNewTask {
                showAlert(with: "Введите уникальное название задачи")
                return false
            }
        }
        return true
    }
}

extension NewItemViewController {
    private func showAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

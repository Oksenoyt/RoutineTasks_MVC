//
//  NewItemViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 10.07.2022.
//

import UIKit

class NewItemViewController: UIViewController {
    let date = DateManager()
    var delegate:NewItemViewControllerDelegate!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var itemColorUIStackView: [UIButton]!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 30
        createButton.layer.cornerRadius = 15
        setTextField()
        for itemColorView in itemColorUIStackView {
            itemColorView.layer.cornerRadius = 15
        }
        
    }
    //    override func viewWillLayoutSubviews() {
    //        for itemColorView in itemColorUIStackView {
    //            itemColorView.layer.cornerRadius = 15
    //        }
    //    }
    
    @IBAction func createButton(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(with: "Заполните название задачи", and: "qwewqweqwe")
            //текст
            return }
        
        let color = "#c49dcc"
        let currentDate = date.getDateString(dayBefore: 0)
        
        StorageManager.shared.createTask(taskName: name, color: color, date: currentDate) { task in
            delegate.addNewTask(task: task)
        }
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
}

extension NewItemViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        present(alert, animated: true)
    }
}

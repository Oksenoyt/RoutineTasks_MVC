//
//  NewItemViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 10.07.2022.
//

import UIKit

class NewItemViewController: UIViewController {
    let date = DateManager()
    
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
        
//        var name = "Уборка домааа1" //let
        let color = "#c49dcc"
        let currentData = date.getDateString(dayBefore: 0)
        
        StorageManager.shared.create(taskName: name, color: color, startDate: currentData) { task in
            print(1)
        }
        
        
        //        var name = "Уборка домааа1" //let
        //        let color = "#c49dcc"
        //        let currentData = date.getDateString(dayBefore: 0)
        //        //сделать проверку на одинаковые названия
        //
        //        StorageManager.shared.create(taskName: name, color: color, startDate: date.getDateString(dayBefore: 0)) { task in
        //            print(1)
        //        }
        //        name = "Уборка домааа1"
        //        StorageManager.shared.create(taskName: name, color: color, startDate: date.getDateString(dayBefore: 1)) { task in
        //            print(2)
        //        }
        //        name = "Уборка домааа1"
        //
        //        StorageManager.shared.create(taskName: name, color: color, startDate: date.getDateString(dayBefore: 2)) { task in
        //            print(3)
        //        }
        //        name = "qweqwe3"
        //
        //        StorageManager.shared.create(taskName: name, color: color, startDate: date.getDateString(dayBefore: 3)) { task in
        //            print(4)
        //        }
    }
    
    private func setTextField() {
        nameTextField.layer.masksToBounds = true
        nameTextField.layer.cornerRadius = 30
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.becomeFirstResponder()
        nameTextField.returnKeyType = UIReturnKeyType.done ///????
        //       nameTextField.delegate = self
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension NewItemViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        present(alert, animated: true)
    }
}

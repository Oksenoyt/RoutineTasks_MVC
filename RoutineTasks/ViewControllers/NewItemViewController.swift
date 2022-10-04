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
//        nameTextField.layer.borderWidth = 2
//        nameTextField.layer.borderColor = UIColor.black.cgColor
//        nameTextField.layer.cornerRadius = 25
//        nameTextField.layer.masksToBounds = true

    }
    override func viewWillLayoutSubviews() {
        createButton.layer.cornerRadius = 15
        view.layer.cornerRadius = 30
//        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.cornerRadius = 30
        nameTextField.clearButtonMode = .whileEditing
        
        for itemColorView in itemColorUIStackView {
            itemColorView.layer.cornerRadius = 15
        }
    }

    @IBAction func createButton(_ sender: UIButton) {
        var name = "Уборка домааа1" //let
        let color = "#c49dcc"
        let currentData = date.getDateString(dayBefore: 0)
        //сделать проверку на одинаковые названия
        
        StorageManager.shared.create(taskName: name, color: color, startDate: date.getDateString(dayBefore: 0)) { task in
            print(1)
        }
        name = "Уборка домааа1"
        StorageManager.shared.create(taskName: name, color: color, startDate: date.getDateString(dayBefore: 1)) { task in
            print(2)
        }
        name = "Уборка домааа1"
        
        StorageManager.shared.create(taskName: name, color: color, startDate: date.getDateString(dayBefore: 2)) { task in
            print(3)
        }
        name = "qweqwe3"
        
        StorageManager.shared.create(taskName: name, color: color, startDate: date.getDateString(dayBefore: 3)) { task in
            print(4)
        }
        
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

//
//  NewItemViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 10.07.2022.
//

import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet var itemColorUIStackView: [UIButton]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        nameTextField.layer.borderWidth = 2
//        nameTextField.layer.borderColor = UIColor.black.cgColor
//        nameTextField.layer.cornerRadius = 25
//        nameTextField.layer.masksToBounds = true

    }
    override func viewWillLayoutSubviews() {
        for itemColorView in itemColorUIStackView {
            itemColorView.layer.cornerRadius = 15
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

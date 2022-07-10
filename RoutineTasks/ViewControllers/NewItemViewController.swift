//
//  NewItemViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 10.07.2022.
//

import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var itemColorUIStackView: UIStackView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        nameTextField.layer.borderWidth = 2
//        nameTextField.layer.borderColor = UIColor.black.cgColor
//        nameTextField.layer.cornerRadius = 25
//        nameTextField.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        itemColorUIStackView.viewWithTag(1)?.layer.cornerRadius = (itemColorUIStackView.viewWithTag(1)?.frame.width ?? 0) / 2
        itemColorUIStackView.viewWithTag(2)?.layer.cornerRadius = (itemColorUIStackView.viewWithTag(1)?.frame.width ?? 0) / 2
        itemColorUIStackView.viewWithTag(3)?.layer.cornerRadius = (itemColorUIStackView.viewWithTag(1)?.frame.width ?? 0) / 2
        itemColorUIStackView.viewWithTag(4)?.layer.cornerRadius = (itemColorUIStackView.viewWithTag(1)?.frame.width ?? 0) / 2
        itemColorUIStackView.viewWithTag(5)?.layer.cornerRadius = (itemColorUIStackView.viewWithTag(1)?.frame.width ?? 0) / 2
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

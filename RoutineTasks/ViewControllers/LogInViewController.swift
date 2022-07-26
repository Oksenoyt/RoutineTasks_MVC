//
//  LogInViewController.swift
//  RoutineTasks
//
//  Created by Elena Kholodilina on 17.07.2022.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let user = User.getUser()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
    
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func logInButtonPressed() {
        guard loginTextField.text == user.login,
        passwordTextField.text == user.password else {
            showAlert(title: "Error", message: "Error")
            return
        }
    }
    
    
}

extension LogInViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

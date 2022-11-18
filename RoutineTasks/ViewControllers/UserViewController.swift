//
//  AutorizationViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 04.07.2022.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var autotizFormButton: UIButton!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var createFormButton: UIButton!
    @IBOutlet weak var createStackView: UIStackView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var repeatPassTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    var delegate: UserViewControllerDelegate!
    var taskList: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFormButton.layer.cornerRadius = 15
        autotizFormButton.layer.cornerRadius = 15
        loginButton.layer.cornerRadius = 15
        createButton.layer.cornerRadius = 15
        
        avtorizFormActive()
    }
    
    @IBAction func createFormButton(_ sender: Any) {
        createFormActive()
    }
    
    @IBAction func autorizeFormButtom(_ sender: Any) {
        avtorizFormActive()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let login = loginTextField.text, !login.isEmpty else { return }
        guard let pass = passwordTextField.text, !pass.isEmpty else { return }
        StorageManager.shared.fetchUser(email: login) { result in
            switch result {
            case .success(let user):
                if user.password == pass {
                    delegate.addUser(user)
                    dismiss(animated: true)
                } else {
                    showAlert(with: "не верный логин или пароль")
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
        showAlert(with: "не верный логин или пароль")
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        showAlert(with: "Восстановление пароля")
        //        guard let email =
        //        StorageManager.shared.fetchUser(email: email) { result in
        //            switch result {
        //            case .success( let user):
        //
        //            case .failure( let error):
        //                print(error)
        //            }
        //        }
    }
    
    @IBAction func createButton(_ sender: Any) {
        guard let name = userNameTextField.text, !name.isEmpty else { return }
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let pass = passTextField.text, !pass.isEmpty else { return }
        guard let repeatPass = repeatPassTextField.text, !repeatPass.isEmpty, repeatPass==pass else {
//            showAlert(with: "Не верный логин(email) или пароль")
            showAlert(with: "пароль не совпадает")
            return
        }
        
        if checkEmail(email) {
            StorageManager.shared.createUser(name: name, email: email, password: pass, tasks: taskList) { newUser, tasks in
                delegate.addUser(newUser)
                delegate.addUserForTasks(tasks)
                dismiss(animated: true)
            }
        } else {
            showAlert(with: "Такой email уже зарегестрирован")
            print("такой пользователь уже есть")
        }
    }
    
    private func avtorizFormActive() {
        createStackView.isHidden = true
        loginStackView.isHidden = false
        autotizFormButton.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.7764705882, blue: 0.8784313725, alpha: 1)
        createFormButton.backgroundColor = .clear
        createFormButton.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.9176470588, blue: 0.737254902, alpha: 1)
        createFormButton.layer.borderWidth = 5
        loginButton.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.7764705882, blue: 0.8784313725, alpha: 1)
        loginButton.layer.borderWidth = 5
    }
    
    private func createFormActive() {
        loginStackView.isHidden = true
        createStackView.isHidden = false
        createFormButton.backgroundColor = #colorLiteral(red: 0.6588235294, green: 0.9176470588, blue: 0.737254902, alpha: 1)
        autotizFormButton.backgroundColor = .clear
        autotizFormButton.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.7764705882, blue: 0.8784313725, alpha: 1)
        autotizFormButton.layer.borderWidth = 5
        createButton.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.9176470588, blue: 0.737254902, alpha: 1)
        createButton.layer.borderWidth = 5
    }
    
    private func checkEmail(_ email: String) -> Bool {
        var check = true
        StorageManager.shared.fetchUser(email: email) { result in
            switch result {
            case .success(_):
                check = false
            case .failure(let error):
                print(error)
            }
        }
        return check
    }
}

extension UserViewController {
    private func showAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}

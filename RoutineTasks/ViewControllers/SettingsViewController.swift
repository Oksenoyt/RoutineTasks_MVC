//
//  ViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 04.07.2022.
//

import UIKit

protocol UserViewControllerDelegate {
    func addUser(_ user: User)
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var autorizButton: UIBarButtonItem!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 30
        
        checkAutorizUser()
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        guard let user = self.user else {
            print("Пользователь не авторизован") // убрать?
            //alert
            return
        }
            StorageManager.shared.deleteUser(user)
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userVC = segue.destination as? UserViewController else { return }
        userVC.delegate = self
    }
    
    private func checkAutorizUser() {
        if let currentUser = user {
            setSettings(for: currentUser)
        } else {
            print("Пользователь не авторизован") // убрать?
        }
    }
    
    private func setSettings(for user: User) {
        autorizButton.title = "Выйти"
        userNameLabel.text = user.name
        deleteAccountButton.isEnabled = true
    }
}

// MARK: - UserViewControllerDelegate
extension SettingsViewController: UserViewControllerDelegate {
    func addUser(_ user: User) {
        self.user = user
        checkAutorizUser()
    }
}

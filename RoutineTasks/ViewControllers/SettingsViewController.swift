//
//  ViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 04.07.2022.
//

import UIKit

protocol UserViewControllerDelegate {
    func addUser(_ user: User)
    func addUserForTasks(_ tasks: [Task])
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var autorizButton: UIBarButtonItem!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    var user: User?
    var taskList: [Task] = []
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 30
        
        if taskList.first?.user != nil {
            user = taskList.first?.user
        }
        
        checkAutorizUser()
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
       if let currentUser = user {
           StorageManager.shared.deleteUser(currentUser, with: taskList)
       } else {
           print("Пользователь не авторизован") // убрать?
       }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userVC = segue.destination as? UserViewController else { return }
        userVC.taskList = taskList
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
    func addUserForTasks(_ tasks: [Task]) {
        taskList = tasks
    }

    func addUser(_ user: User) {
        //переделать селф
        self.user = user
        delegate.getUser(user)
        checkAutorizUser()
    }
}

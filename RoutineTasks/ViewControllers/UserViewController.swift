//
//  AutorizationViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 04.07.2022.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var createFormButton: UIButton!
    @IBOutlet weak var autotizFormButton: UIButton!
    
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var createStackView: UIStackView!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFormButton.layer.cornerRadius = 15
        autotizFormButton.layer.cornerRadius = 15
        loginButton.layer.cornerRadius = 15
        createButton.layer.cornerRadius = 15
        
        avtorizFormActive()
    }
    
    @IBAction func createButton(_ sender: Any) {
        createFormActive()
    }
    
    @IBAction func autorizeButtom(_ sender: Any) {
        avtorizFormActive()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
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
}

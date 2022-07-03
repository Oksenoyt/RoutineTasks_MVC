//
//  ViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 27.06.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var addNewItemButton: UIBarButtonItem!
    @IBOutlet weak var backgroudView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroudView.layer.cornerRadius = 30
        
    }


}


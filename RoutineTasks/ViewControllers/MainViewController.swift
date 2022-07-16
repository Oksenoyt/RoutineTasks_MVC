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
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var datesStackView: UIStackView!
    
    @IBOutlet weak var calendarLabel: UILabel!
    
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 30
        calendarLabel.text = date.dayBefore(value: -2).toRusString
        
    }


}

extension Date {
    var toRusString: String {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_Ru")
        dateFormater.setLocalizedDateFormatFromTemplate("EE \n dd")
        return dateFormater.string(from: self)
    }
    
    func dayBefore(value: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: value, to: Date())!
    }
    
}

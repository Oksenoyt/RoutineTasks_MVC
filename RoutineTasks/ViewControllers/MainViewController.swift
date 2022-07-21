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
    
    @IBOutlet var dayLabels: [UILabel]!
    
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 30
        setCalendar()
    }
    
    private func setCalendar() {
        dayLabels[0].text = date.dayBefore(value: -2).toRusString
        dayLabels[1].text = date.dayBefore(value: -1).toRusString
        dayLabels[2].text = date.dayBefore(value: 0).toRusString
        dayLabels[3].text = date.dayBefore(value: 1).toRusString
        dayLabels[4].text = date.dayBefore(value: 2).toRusString
    }
}

// MARK:  - MainViewController
extension Date {
    var toRusString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_Ru")
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        let dayNumber = dateFormatter.string(from: self)
        dateFormatter.setLocalizedDateFormatFromTemplate("EE")
        let dayWeek = dateFormatter.string(from: self)
        
        return "\(dayNumber)\n\(dayWeek)"
    }
    
    func dayBefore(value: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: value, to: Date())!
    }
    
}

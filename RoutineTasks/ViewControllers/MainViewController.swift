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
    
    @IBOutlet weak var taskListTableView: UITableView!
    @IBOutlet var dayLabels: [UILabel]!
    
    let date = Date()
    let taskList = Task.getNewTask()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        taskListTableView.backgroundColor = #colorLiteral(red: 0.9536015391, green: 0.9351417422, blue: 0.9531318545, alpha: 1)
        taskListTableView.layer.cornerRadius = 30
    }
    
    private func setCalendar() {
        dayLabels[0].text = date.dayBefore(value: -2).toRusString
        dayLabels[1].text = date.dayBefore(value: -1).toRusString
        dayLabels[2].text = date.dayBefore(value: 0).toRusString
        dayLabels[3].text = date.dayBefore(value: 1).toRusString
        dayLabels[4].text = date.dayBefore(value: 2).toRusString
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task", for: indexPath)
        let task = taskList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        cell.backgroundColor = #colorLiteral(red: 0.9536015391, green: 0.9351417422, blue: 0.9531318545, alpha: 1)
        
        return cell
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

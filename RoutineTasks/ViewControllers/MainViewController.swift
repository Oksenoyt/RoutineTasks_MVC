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
        var dayNumber = -2
        for dayLabel in dayLabels {
            dayLabel.text = date.dayBefore(value: dayNumber).toRusString
            dayNumber += 1
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellError = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell else { return cellError }
        let task = taskList[indexPath.row]
        cell.nameTaskLabel.text = task.title
        
        for checkDoTaskButton in cell.checkDoTaskStackButton {
            switch checkDoTaskButton.tag {
            case 0:
                let dataForButton = "24-07-2022"
                if task.completionDays[dataForButton] ?? false  {
                    checkDoTaskButton.backgroundColor = UIColor.init(named: task.color)
                }
            case 1:
                let dataForButton = "25-07-2022"
                if task.completionDays[dataForButton] ?? false  {
                    checkDoTaskButton.backgroundColor = UIColor.init(named: task.color)
                }
            case 2:
                let dataForButton = "26-07-2022"
                if task.completionDays[dataForButton] ?? false  {
                    checkDoTaskButton.backgroundColor = UIColor.init(named: task.color)
                }
            default:
                break
            }
        }
        return cell    //        переделать!!!!
    }
}

// MARK: - UITableViewDelegate


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


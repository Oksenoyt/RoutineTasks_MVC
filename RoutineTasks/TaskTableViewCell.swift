//
//  TaskTableViewCell.swift
//  RoutineTasks
//
//  Created by Elenka on 24.07.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet var StackDaysButton: [UIButton]!
    @IBOutlet weak var nameTaskLabel: UILabel!
    
    var task: Task!
    var completionDays: [CompletionDays] = []
    private let date = DateManager()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) //??
    }
    
    @IBAction func setDoneTask(_ sender: UIButton) {
        var taskDate = ""
        var dayWeek = ""
        switch sender.tag {
        case 0:
            taskDate = date.getDateString(dayBefore: 2, format: .yyyyMMdd)
            dayWeek = date.getDateString(dayBefore: 2, format: .EE)
        case 1:
            taskDate = date.getDateString(dayBefore: 1, format: .yyyyMMdd)
            dayWeek = date.getDateString(dayBefore: 1, format: .EE)
        case 2: //нужен ли
            taskDate = date.getDateString(dayBefore: 0, format: .yyyyMMdd)
            dayWeek = date.getDateString(dayBefore: 0, format: .EE)
        default:
            break
        }
        
        //слабую ссылку self
        let completionDayOpt = completionDays.first { completionDays in
            completionDays.date == taskDate
        }
        if let completionDay = completionDayOpt {
            StorageManager.shared.updateCompletionDay(completionDay)
            setColorDone(completionDay: completionDay, for: StackDaysButton[sender.tag])
        } else {
            StorageManager.shared.createCompletionDay(task, date: taskDate, dayWeek: dayWeek) { completionDay in
                setColorDone(completionDay: completionDay, for: StackDaysButton[sender.tag])
            }
        }
        
        StorageManager.shared.fetchCompletionDays(task) { result in
            switch result {
            case .success(let completionDays):
                self.completionDays = completionDays
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func configure(with task: Task) {
        nameTaskLabel.text = task.title
        if let completions = task.completion.allObjects as? [CompletionDays] {
            completionDays = completions
        }
        self.task = task // сделать weak
        checkDoneDayButton()
    }
    
    private func checkDayActive(day: CompletionDays) -> Bool{
        let currentDay = day.dayWeek
        var dayActive = false
        switch currentDay {
        case "Пн":
            if task.schedule.monday {
                dayActive = true
            }
        case "Вт":
            if task.schedule.tuesday {
                dayActive = true
            }
        case "Ср":
            if task.schedule.wednesday {
                dayActive = true
            }
        case "Чт":
            if task.schedule.thursday {
                dayActive = true
            }
        case "Пт":
            if task.schedule.friday {
                dayActive = true
            }
        case "Сб":
            if task.schedule.saturday {
                dayActive = true
            }
        default:
            if task.schedule.sunday {
                dayActive = true
            }
        }
        return dayActive
    }
    
    private func checkDoneDayButton() {
        let curentDay = date.getDateString(dayBefore: 0, format: .yyyyMMdd)
        let yesterday = date.getDateString(dayBefore: 1, format: .yyyyMMdd)
        let dayBeforeYesterday = date.getDateString(dayBefore: 2, format: .yyyyMMdd)
        
            for dayButton in StackDaysButton {
                dayButton.layer.cornerRadius = 16
                
                switch dayButton.tag {
                case 0:
                    for completionDay in completionDays {
                        if  completionDay.date == dayBeforeYesterday {
                            setColorDone(completionDay: completionDay, for: dayButton)
                        }
                    }
                case 1:
                    for completionDay in completionDays {
                        if completionDay.date == yesterday {
                            setColorDone(completionDay: completionDay, for: dayButton)
                        }
                    }
                case 2:
                    for completionDay in completionDays {
                        if completionDay.date == curentDay {
                            setColorDone(completionDay: completionDay, for: dayButton)
                        }
                    }
                default:
                    break
                }
            }
        
    }
    
    private func setColorDone(completionDay: CompletionDays, for checkDoTaskButton: UIButton) {
            if completionDay.isDone {
                checkDoTaskButton.backgroundColor = UIColor.init(named: task.color)
            } else {
                checkDoTaskButton.backgroundColor = .clear
            }
    }
}

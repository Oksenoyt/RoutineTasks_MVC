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
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func setDoneTask(_ sender: UIButton) {
        var taskDate = date.getDateString(dayBefore: 0, format: .yyyyMMdd) //переделать
        switch sender.tag {
        case 0:
            taskDate = date.getDateString(dayBefore: 2, format: .yyyyMMdd)
        case 1:
            taskDate = date.getDateString(dayBefore: 1, format: .yyyyMMdd)
        case 2:
            taskDate = date.getDateString(dayBefore: 0, format: .yyyyMMdd)
        default:
            break
        }
        StorageManager.shared.updateStatus(task, date: taskDate)
        //слабую ссылку self
        StorageManager.shared.fetchCompletionDays(task) { result in
            switch result {
            case .success(let completionDays):
                self.completionDays = completionDays
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        checkDoneTaskView()
    }
    
    func configure(with task: Task) {
        nameTaskLabel.text = task.title
        if let completions = task.completion.allObjects as? [CompletionDays] {
            completionDays = completions
        }
        self.task = task // сделать weak
        checkDoneTaskView()
    }
    
    private func checkDayActive() {
        
    }
    
    private func checkDoneTaskView() {
        let curentDay = date.getDateString(dayBefore: 0, format: .yyyyMMdd)
        let yesterday = date.getDateString(dayBefore: 1, format: .yyyyMMdd)
        let dayBeforeYesterday = date.getDateString(dayBefore: 2, format: .yyyyMMdd)
        
        for completionDay in completionDays {
            for dayButton in StackDaysButton {
                dayButton.layer.cornerRadius = 16
                
                switch dayButton.tag {
                case 0:
                    if  completionDay.date == dayBeforeYesterday {
                        setColorDone(completionDay: completionDay, for: dayButton)
                    }
                case 1:
                    if completionDay.date == yesterday {
                        setColorDone(completionDay: completionDay, for: dayButton)
                    }
                case 2:
                    if completionDay.date == curentDay {
                        setColorDone(completionDay: completionDay, for: dayButton)
                    }
                default:
                    break
                }
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

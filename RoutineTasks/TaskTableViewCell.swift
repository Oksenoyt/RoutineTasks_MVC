//
//  TaskTableViewCell.swift
//  RoutineTasks
//
//  Created by Elenka on 24.07.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    private let date = DateManager()
    var task: Task?
    
    @IBOutlet var checkDoTaskStackButton: [UIButton]!
    @IBOutlet weak var nameTaskLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func setDoneTask(_ sender: UIButton) {
        guard let currentTask = task else { return }
        var taskDate: String = date.getDateString(dayBefore: 0)
        switch sender.tag {
        case 0:
            taskDate = date.getDateString(dayBefore: 2)
        case 1:
            taskDate = date.getDateString(dayBefore: 1)
        case 2:
            taskDate = date.getDateString(dayBefore: 0)
        default:
            break
        }
        
        StorageManager.shared.updateData(taskName: currentTask.title, taskDate: taskDate) { result in
            print("resultqweqweqweqwe")
            print(result)
            switch result {
            case .success(let task):
                //разобраться с селф
                self.task = task
                checkDoTaskView(for: task)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configure(with task: Task) {
        nameTaskLabel.text = task.title
        checkDoTaskView(for: task)
        self.task = task
    }
    
    private func checkDoTaskView(for task: Task) {
        let dateTask = task.completion.date
        let isDone = task.completion.isDone
        
        let curentDay = date.getDateString(dayBefore: 0)
        let yesterday = date.getDateString(dayBefore: 1)
        let dayBeforeYesterday = date.getDateString(dayBefore: 2)
        
        for checkDoTaskButton in checkDoTaskStackButton {
            checkDoTaskButton.layer.cornerRadius = 16
//            let color = checkDoTaskButton.backgroundColor = UIColor.init(named: task.color)
//            let clear = checkDoTaskButton.backgroundColor = .clear
//
            switch checkDoTaskButton.tag {
            case 0:
                if  dateTask == dayBeforeYesterday {
                    if isDone {
                        checkDoTaskButton.backgroundColor = UIColor.init(named: task.color)
                    } else {
                        checkDoTaskButton.backgroundColor = .clear
                    }
                }
            case 1:
                if dateTask == yesterday {
                    if isDone {
                        checkDoTaskButton.backgroundColor = UIColor.init(named: task.color)
                    } else {
                        checkDoTaskButton.backgroundColor = .clear
                    }
                }
            case 2:
                if dateTask == curentDay {
                    if isDone {
                        checkDoTaskButton.backgroundColor = UIColor.init(named: task.color)
                    } else {
                        checkDoTaskButton.backgroundColor = .clear
                    }
                }
            default:
                break
            }
        }
    }
}


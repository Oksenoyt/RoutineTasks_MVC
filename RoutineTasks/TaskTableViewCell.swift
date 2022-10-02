//
//  TaskTableViewCell.swift
//  RoutineTasks
//
//  Created by Elenka on 24.07.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    
    let curentDate = Date()
    var task: Task?
    
    @IBOutlet var checkDoTaskStackButton: [UIButton]!
    
    @IBOutlet weak var nameTaskLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func setDoneTask(_ sender: UIButton) {
        guard let currentTask = task else { return }
        let curentDay = curentDate
            .formatted(date: .numeric, time: .omitted)
        
//        StorageManager.shared.updateData(currentTask: currentTask.title, currentDate: curentDay, completion: <#T##(Result<[CompletionDays], Error>) -> Void#>)
    }
    
    func configure(with task: Task) {
        nameTaskLabel.text = task.title
        checkDoTaskView(for: task)
        self.task = task
    }
    
    private func checkDoTaskView(for task: Task) {
        
        let dateTask = task.completion.date.formatted(date: .numeric, time: .omitted)
        let isDone = task.completion.isDone
        
        let curentDay = curentDate
            .formatted(date: .numeric, time: .omitted)
        let yesterday = curentDate.dayBefore(value: -1)
            .formatted(date: .numeric, time: .omitted)
        let dayBeforeYesterday = curentDate.dayBefore(value: -2)
            .formatted(date: .numeric, time: .omitted)
        
        for checkDoTaskButton in checkDoTaskStackButton {
            checkDoTaskButton.layer.cornerRadius = 16
            switch checkDoTaskButton.tag {
            case 0:
                if  dateTask == dayBeforeYesterday {
                    isDone ? checkDoTaskButton.backgroundColor = UIColor.init(named: task.color) : nil
                }
            case 1:
                if dateTask == yesterday {
                    isDone ? checkDoTaskButton.backgroundColor = UIColor.init(named: task.color) : nil
                }
            case 2:
                if dateTask == curentDay {
                    isDone ? checkDoTaskButton.backgroundColor = UIColor.init(named: task.color) : nil
                }
                
            default:
                break
            }
        }
    }
}


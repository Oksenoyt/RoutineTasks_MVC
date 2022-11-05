//
//  ViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 27.06.2022.
//

import UIKit

protocol NewItemViewControllerDelegate {
    func addNewTask(task: Task)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var addNewItemButton: UIBarButtonItem!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var taskListTableView: UITableView!
    @IBOutlet var dayLabels: [UILabel]!
    
    private let date = DateManager()
    
    var taskList:[Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        taskListTableView.backgroundColor = #colorLiteral(red: 0.9536015391, green: 0.9351417422, blue: 0.9531318545, alpha: 1)
        taskListTableView.layer.cornerRadius = 30
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newItemVC = segue.destination as? NewItemViewController else { return }
        newItemVC.delegate = self
        newItemVC.tasks = taskList
    }
    
    private func setCalendar() {
        var dayNumber = -2
        for dayLabel in dayLabels {
            dayLabel.text = date.getDateString(dayBefore: -dayNumber, format: .d_EE)
            if dayNumber == 0 {
                dayLabel.font = .boldSystemFont(ofSize: 19)
            }
            dayNumber += 1
        }
    }
    
    private func fetchData() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let tasks):
                taskList = tasks
            case .failure(let error):
                print(error.localizedDescription)
            }
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
        cell.configure(with: task)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = taskList[indexPath.row]
        
        let deletAction = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            StorageManager.shared.delete(task)
            self.taskList.remove(at: indexPath.row) //self weak
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            print("sdfsdfsdf")
        }
        
        deletAction.backgroundColor = #colorLiteral(red: 0.7979423404, green: 0.6081361771, blue: 0.8128324151, alpha: 1)
        editAction.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.831372549, blue: 0.8352941176, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deletAction, editAction])
    }
    
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        let task = taskList[indexPath.row]
        //        showAlert(task: task) {
        //            tableView.reloadRows(at: [indexPath], with: .automatic)
        //        }
    }
}

// MARK: - NewItemViewControllerDelegate
extension MainViewController: NewItemViewControllerDelegate {
    func addNewTask(task: Task) {
        taskList.append(task)
        taskListTableView.insertRows(
            at: [IndexPath(row: taskList.count - 1, section: 0)],
            with: .automatic
        )
    }
}

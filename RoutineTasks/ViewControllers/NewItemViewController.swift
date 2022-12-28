//
//  NewItemViewController.swift
//  RoutineTasks
//
//  Created by Elenka on 10.07.2022.
//

import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var itemColorStackButton: [UIButton]!
    
    @IBOutlet weak var notificationTextField: UITextField!
    @IBOutlet var scheduleStackButton: [UIButton]!
    @IBOutlet weak var createButton: UIButton!
    
    let date = DateManager()
    let datePicker = UIDatePicker()

    var delegate:NewItemViewControllerDelegate!
    var user: User?
    var tasks: [Task] = []
    var currentTask: Task?
    var editTask: Task?
    private var color = "#c49dcc"
    private var selectedDays = [true, true, true, true, true, true, true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 30
        createButton.layer.cornerRadius = 15
        
        for itemColorButton in itemColorStackButton {
            itemColorButton.layer.cornerRadius = 15
        }
        
        setSettingsNameTF()
        setBorderColorButton(tagButton: 0)
//        переделать на тернарный
        if tasks.first?.user != nil {
            user = tasks.first?.user
        }
        
        createDatePicker()
    }
    
    @IBAction func getColor(_ sender: UIButton) {
        setBorderColorButton(tagButton: sender.tag)
        switch sender.tag {
        case 0:
            color = "#c49dcc"
        case 1:
            color = "#bfd4d5"
        case 2:
            color = "#b096e4"
        case 3:
            color = "#a8eabc"
        default:
            color = "#edc6e0"
        }
    }
    
    @IBAction func scheduleButton(_ sender: UIButton) {
        selectedDays[sender.tag].toggle()
        if scheduleStackButton[sender.tag].tintColor != .gray {
            scheduleStackButton[sender.tag].tintColor = .gray
        } else {
            scheduleStackButton[sender.tag].tintColor = .systemBlue
        }
    }
    
    
    @IBAction func createButton(_ sender: UIButton) {
        createTasck()
        dismiss(animated: true)
    }
    
    private func setSettingsNameTF() {
        nameTextField.layer.masksToBounds = true
        nameTextField.layer.cornerRadius = 30
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.becomeFirstResponder()
        nameTextField.returnKeyType = UIReturnKeyType.done ///????
        //       nameTextField.delegate = self
        
        if let task = editTask {
            nameTextField.placeholder = "Task"
            nameTextField.text = task.title
        }
    }
    
    private func setBorderColorButton(tagButton: Int) {
        for itemColorView in itemColorStackButton {
            itemColorView.layer.borderWidth = 0
        }
        itemColorStackButton[tagButton].layer.borderWidth = 3.0
    }
    
    private func createTasck() {
        let currentDate = date.getDateString(dayBefore: 0, format: .yyyyMMdd)
        let dayWeek = date.getDateString(dayBefore: 0, format: .EE)
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(with: "Заполните название задачи")
            return
        }
        guard checkUniqueName(nameNewTask: name) == true else { return }
        
        StorageManager.shared.createTask(
            id: tasks.count,
            name: name,
            color: color,
            date: currentDate,
            dayWeek: dayWeek,
            selectedDays: selectedDays,
            user: user
        ) {
            task in
            delegate.addNewTask(task: task)
            currentTask = task
        }
    }
    
    private func checkUniqueName(nameNewTask: String) -> Bool {
        for task in tasks {
            if task.title == nameNewTask {
                showAlert(with: "Введите уникальное название задачи")
                return false
            }
        }
        return true
    }
}


//что запихивать в екстеншин?
extension NewItemViewController {
    private func showAlert(with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        notificationTextField.inputView = datePicker
        notificationTextField.inputAccessoryView = createToolPar()
    }
    
    private func createToolPar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //изучить selector
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolBar.setItems([doneButton], animated: true)
        
        return toolBar
    }
    
    //what is it objc?
    @objc private func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        notificationTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
}

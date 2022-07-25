//
//  Task.swift
//  RoutineTasks
//
//  Created by Elenka on 21.07.2022.
//
struct Task {
    let title: String
    let color: String
    let dailyTasks: Bool
//    let repetition: String
//    let remainders: Date
//    let timer: Date
//    let bedHabit: Bool
//    let startTask: Date
//    let endTask: Date
    
    static func getNewTask() -> [Task] {
        [
            Task(
                title: "read",
                color: "#c49dcc",
                dailyTasks: true
//                repetition: "3",
//                remainders: <#T##Date#>,
//                timer: <#T##Date#>,
//                bedHabit: <#T##Bool#>,
//                startTask: <#T##Date#>,
//                endTask: Date
            ),
            
            Task(
                title: "swim",
                color: "#b096e4",
                dailyTasks: true
//                repetition: "3",
//                remainders: <#T##Date#>,
//                timer: <#T##Date#>,
//                bedHabit: <#T##Bool#>,
//                startTask: <#T##Date#>,
//                endTask: Date
            ),
            
            Task(
                title: "run",
                color: "#a8eabc",
                dailyTasks: true
            ),
            Task(
                title: "walk the dog",
                color: "#edc6e0",
                dailyTasks: false
            ),
            Task(
                title: "wash dishes",
                color: "#c49dcc",
                dailyTasks: true
            ),
            Task(
                title: "run",
                color: "#bbece6",
                dailyTasks: false
            ),
            Task(
                title: "walk the dog",
                color: "#c49dcc",
                dailyTasks: true
            ),
            Task(
                title: "swim",
                color: "#c49dcc",
                dailyTasks: false
            ),
            Task(
                title: "run",
                color: "#a8eabc",
                dailyTasks: true
            ),
            Task(
                title: "walk the dog",
                color: "#edc6e0",
                dailyTasks: false
            ),
            Task(
                title: "wash dishes",
                color: "#c49dcc",
                dailyTasks: true
            ),
            Task(
                title: "run",
                color: "#bbece6",
                dailyTasks: false
            ),
            Task(
                title: "walk the dog",
                color: "#c49dcc",
                dailyTasks: true
            ),
            Task(
                title: "swim",
                color: "#c49dcc",
                dailyTasks: false
            )
        ]
    }
}

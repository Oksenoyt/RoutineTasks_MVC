//
//  Task.swift
//  RoutineTasks
//
//  Created by Elenka on 21.07.2022.
//
struct Task {
    let title: String
    let taskColor: String
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
                taskColor: "Red"
//                repetition: "3",
//                remainders: <#T##Date#>,
//                timer: <#T##Date#>,
//                bedHabit: <#T##Bool#>,
//                startTask: <#T##Date#>,
//                endTask: Date
            ),
            
            Task(
                title: "swim",
                taskColor: "Blue"
//                repetition: "3",
//                remainders: <#T##Date#>,
//                timer: <#T##Date#>,
//                bedHabit: <#T##Bool#>,
//                startTask: <#T##Date#>,
//                endTask: Date
            ),
            
            Task(
                title: "run",
                taskColor: "Blue"
            ),
            Task(
                title: "walk the dog",
                taskColor: "Blue"
            ),
            Task(
                title: "wash dishes",
                taskColor: "Blue"
            ),
            Task(
                title: "run",
                taskColor: "Blue"
            ),
            Task(
                title: "walk the dog",
                taskColor: "Blue"
            ),
            Task(
                title: "swim",
                taskColor: "Blue"
            )
        ]
    }
}

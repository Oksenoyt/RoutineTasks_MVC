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
                title: "Reading",
                taskColor: "Red"
//                repetition: "3",
//                remainders: <#T##Date#>,
//                timer: <#T##Date#>,
//                bedHabit: <#T##Bool#>,
//                startTask: <#T##Date#>,
//                endTask: Date
            ),
            
            Task(
                title: "swimming",
                taskColor: "Blue"
//                repetition: "3",
//                remainders: <#T##Date#>,
//                timer: <#T##Date#>,
//                bedHabit: <#T##Bool#>,
//                startTask: <#T##Date#>,
//                endTask: Date
            ),
            
            Task(
                title: "1swimming",
                taskColor: "Blue"
            ),
            Task(
                title: "2swimming",
                taskColor: "Blue"
            ),
            Task(
                title: "3swimming",
                taskColor: "Blue"
            ),
            Task(
                title: "4swimming",
                taskColor: "Blue"
            ),
            Task(
                title: "5swimming",
                taskColor: "Blue"
            ),
            Task(
                title: "6swimming",
                taskColor: "Blue"
            ),
            Task(
                title: "7swimming",
                taskColor: "Blue"
            )
        ]
    }
}

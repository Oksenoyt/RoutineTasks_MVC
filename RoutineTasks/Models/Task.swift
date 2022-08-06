//
//  Task.swift
//  RoutineTasks
//
//  Created by Elenka on 21.07.2022.
//
struct Task {
    let title: String
    let color: String
    var completionDays: [String: Bool]
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
                completionDays: ["26-07-2022": true]
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
                completionDays: ["24-07-2022": true, "26-07-2022": true]
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
                completionDays: ["25-07-2022": true]
            ),
            Task(
                title: "walk the dog",
                color: "#edc6e0",
                completionDays: ["26-07-2022": false]
            ),
            Task(
                title: "wash dishes",
                color: "#c49dcc",
                completionDays: ["26-07-2022": true]
            ),
            Task(
                title: "run",
                color: "#bbece6",
                completionDays: ["26-07-2022": false]
            ),
            Task(
                title: "walk the dog",
                color: "#c49dcc",
                completionDays: ["24-07-2022": true]
            ),
            Task(
                title: "swim",
                color: "#c49dcc",
                completionDays: ["26-07-2022": false]
            ),
            Task(
                title: "run",
                color: "#a8eabc",
                completionDays: ["26-07-2022": true]
            ),
            Task(
                title: "walk the dog",
                color: "#edc6e0",
                completionDays: ["24-07-2022": false]
            ),
            Task(
                title: "wash dishes",
                color: "#c49dcc",
                completionDays: ["25-07-2022": true, "26-07-2022": true]
            ),
            Task(
                title: "run",
                color: "#bbece6",
                completionDays: ["26-07-2022": false]
            ),
            Task(
                title: "walk the dog",
                color: "#c49dcc",
                completionDays: ["25-07-2022": true]
            ),
            Task(
                title: "swim",
                color: "#c49dcc",
                completionDays: ["26-07-2022": false]
            )
        ]
    }
}

//class TaskManager {
//    let dataStore = DataStore()
//
//    func addMarkDone() {
//
//    }
//}

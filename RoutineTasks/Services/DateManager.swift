//
//  DateManager.swift
//  RoutineTasks
//
//  Created by Elenka on 02.10.2022.
//

import Foundation

class DateManager {
    
    private let currentDate = Date()
    private let calendar = Calendar.current
    
//    func getDate(dayBefore: Int) -> Date {
//        let components = calendar.dateComponents( [.day, .month, .year], from: currentDate)
//        let today = calendar.date(from: components) ?? currentDate
//        let date = today.dayBefore(value: dayBefore)
//        return date
//    }
    
    func getDateString(dayBefore: Int) -> String {
        let date = currentDate.dayBefore(value: -dayBefore)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}

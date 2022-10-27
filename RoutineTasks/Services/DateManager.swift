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
    
    enum formatDate {
        case yyyyMMdd
        case d_EE
        case EE
    }
    
    func getDateString(dayBefore: Int, format: formatDate ) -> String {
        let date = currentDate.dayBefore(value: -dayBefore)
        let dateFormatter = DateFormatter()
        var dataFormatted = ""
        switch format {
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dataFormatted = dateFormatter.string(from: date)
        case .d_EE:
            dateFormatter.locale = Locale(identifier: "ru_Ru")
            dateFormatter.setLocalizedDateFormatFromTemplate("d")
            let dayNumber = dateFormatter.string(from: date)
            dateFormatter.setLocalizedDateFormatFromTemplate("EE")
            let dayWeek = dateFormatter.string(from: date)
            dataFormatted = "\(dayNumber)\n\(dayWeek)"
        case .EE:
            dateFormatter.setLocalizedDateFormatFromTemplate("EE")
            dataFormatted = dateFormatter.string(from: date)
        }
        return dataFormatted
    }
}

// MARK:  - DateManager
extension Date {
    func dayBefore(value: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: value, to: Date())!
    }
}

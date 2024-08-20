//
//  DateRange.swift
//  SportsApp
//
//  Created by Mohamed Ayman on 20/08/2024.
//

import Foundation

enum DateRange: String {
    case prevYear
    case nextYear
    
    var query: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        
        switch self {
        case .prevYear:
            let pastYear = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!
            //            return "&from=\(formatter.string(from: pastYear))&to=\(formatter.string(from: currentDate))"
#warning("For testing perpose")
            let prevDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            return "&from=\(formatter.string(from: pastYear))&to=\(formatter.string(from: prevDay))"
        case .nextYear:
            let comingYear = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!
            //            return "&from=\(formatter.string(from: currentDate))&to=\(formatter.string(from: comingYear))"
            let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            return "&from=\(formatter.string(from: nextDay))&to=\(formatter.string(from: comingYear))"
        }
    }
}

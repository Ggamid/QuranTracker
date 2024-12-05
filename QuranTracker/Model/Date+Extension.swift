//
//  Date+Extension.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 21.11.2024.
//

import Foundation

extension Date {
    func getWeekDayInInt() -> Int {
        let americanWeekDayNum = Calendar.current.component(.weekday, from: self)
        switch americanWeekDayNum {
        case 1: return 7
        case 2: return 1
        case 3: return 2
        case 4: return 3
        case 5: return 4
        case 6: return 5
        case 7: return 6
        default: return 0
        }
    }

    static func getWeekDayInString(from intWeekDay: Int) -> String {
        switch intWeekDay {
        case 7:
            "Вс"
        case 6:
            "Сб"
        case 5:
            "Пт"
        case 4:
            "Чт"
        case 3:
            "Ср"
        case 2:
            "Вт"
        case 1:
            "Пн"
        default:
            ""
        }
    }
    static let hourInSeconds: Double = 60*60
    static let dayInSeconds: Double = hourInSeconds * 24
    static let weekInSeconds: Double = dayInSeconds * 7
    static let monthInSeconds: Double = dayInSeconds * 31

    static func getStringDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"

        return formatter.string(from: date)
    }

    // Функция для получения даты начала недели
    static func startOfWeek(from date: Date) -> Date? {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        return startOfWeek
    }

    // Функция для получения даты конца недели
    static func endOfWeek(from date: Date) -> Date? {
        guard let startOfWeek = startOfWeek(from: date) else { return nil }
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: 6, to: startOfWeek)
    }

    static func getStartAndEndOfWeek(from date: Date) -> String {
        guard let endOfWeek = endOfWeek(from: date) else { return " " }
        guard let startOfWeek = startOfWeek(from: date) else { return " " }
        return "\(getStringDate(date: startOfWeek)) - \(getStringDate(date: endOfWeek))"
    }
    
    // MARK: For calenderView
    static var firstDayOfWeek = Calendar.current.firstWeekday
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
   var firstWeekDayBeforeStart: Date {
       let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
       var numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek
       if numberFromPreviousMonth < 0 {
           numberFromPreviousMonth += 7 // Adjust to a 0-6 range if negative
       }
       return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
   }

    var calendarDisplayDays: [Date] {
       var days: [Date] = []
       // Start with days from the previous month to fill the grid
       let firstDisplayDay = firstWeekDayBeforeStart
       var day = firstDisplayDay
       while day < startOfMonth {
           days.append(day)
           day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
       }
       // Add days of the current month
       for dayOffset in 0..<numberOfDaysInMonth {
           let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
           days.append(newDay!)
       }
       return days
    }
    
    var yearInt: Int {
        Calendar.current.component(.year, from: self)
    }

    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

}

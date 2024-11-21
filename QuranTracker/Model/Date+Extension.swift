//
//  Date+Extension.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 21.11.2024.
//

import Foundation

extension Date {
    func getWeekDayInInt() -> Int {
        Calendar.current.component(.weekday, from: self)
    }

    static func getWeekDayInString(from intWeekDay: Int) -> String {
        switch intWeekDay {
        case 7:
            "Сб"
        case 6:
            "Пт"
        case 5:
            "Чт"
        case 4:
            "Ср"
        case 3:
            "Вт"
        case 2:
            "Пн"
        case 1:
            "Вс"
        default:
            ""
        }
    }
}

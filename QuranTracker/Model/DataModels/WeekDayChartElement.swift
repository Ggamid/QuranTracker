//
//  WeekDayChartElement.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 20.11.2024.
//

import Foundation

final class WeekDayChartElement: Identifiable {
    let id = UUID()
    var amountOfPage: Int = 0
    let weekDay: String

    init(amountOfPage: Int, weekDay: String) {
        self.amountOfPage = amountOfPage
        self.weekDay = weekDay
    }
}

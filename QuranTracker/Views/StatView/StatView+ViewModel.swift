//
//  StatView+ViewModel.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 24.11.2024.
//

import Foundation

extension StatView {
    @Observable
    final class ViewModel {
        var currentDate: Date = .now
        var date: Date = .now
        var weekDaysArr: [WeekDayChartElement] = []
        
        var isCurrentWeek: Bool {
            currentDate.timeIntervalSince1970 == date.timeIntervalSince1970
        }

        // для получения сессий чтения для текущей недели
        func getWeekStatArr(from readingSessions: [QuranReadingSession], date: Date) {

            guard let endOfWeek = Date.endOfWeek(from: date) else { return }
            guard let startOfWeek = Date.startOfWeek(from: date) else { return }
            
            let thisWeekReadingSessions = readingSessions.filter {
                $0.sessionDate.timeIntervalSince1970 >= startOfWeek.timeIntervalSince1970 &&
                $0.sessionDate.timeIntervalSince1970 <= endOfWeek.timeIntervalSince1970 + Date.dayInSeconds
            }

            let weekStatArr: [WeekDayChartElement] = generateArrForWeekStat()

            for weekDayStatIndex in 0..<weekStatArr.count {
                for readingSessionIndex in 0..<thisWeekReadingSessions.count {

                    let readingSession = thisWeekReadingSessions[readingSessionIndex]
                    let weekDayStat = weekStatArr[weekDayStatIndex]

                    if weekDayStat.weekDay == readingSession.weekDay {
                        weekDayStat.amountOfPage += readingSession.pageAmount
                    }
                }
            }

            weekDaysArr = weekStatArr
        }

        func generateArrForWeekStat() -> [WeekDayChartElement] {
            var weekStatArr: [WeekDayChartElement] = []
            for weekDayNum in 1...7 {
                weekStatArr.append(
                    WeekDayChartElement(
                        amountOfPage: 0,
                        weekDay: Date.getWeekDayInString(from: weekDayNum)
                    )
                )
            }
            return weekStatArr
        }

        func getMaxAmountOfPage() -> Int {
            (weekDaysArr.sorted(by: { $0.amountOfPage < $1.amountOfPage }).last?.amountOfPage ?? 30) + 10
        }
        
        func increaseDateAndUpdateChart(with readingSessions: [QuranReadingSession]) {
            date = Date(timeIntervalSince1970: date.timeIntervalSince1970 + Date.weekInSeconds)
            getWeekStatArr(from: readingSessions, date: date)
        }
        
        func decreaseDateAndUpdateChart(with readingSessions: [QuranReadingSession]) {
            date = Date(timeIntervalSince1970: date.timeIntervalSince1970 - Date.weekInSeconds)
            getWeekStatArr(from: readingSessions, date: date)
        }
    }
}

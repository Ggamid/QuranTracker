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
        var weekChartDate: Date = .now
        var monthChartDate: Date = .now
        
        var weekDaysArr: [WeekDayChartElement] = []
        var currentMonthSessions: [Int?] = []
        
        var writeProgressOffset: Int = 0
        var blurRadius: CGFloat = 7
        
        var isCurrentWeek: Bool {
            currentDate.weekInt == weekChartDate.weekInt
        }

        // для получения сессий чтения для текущей недели
        func getWeekStatArr(from readingSessions: [QuranReadingSession]) {

            guard let endOfWeek = Date.endOfWeek(from: weekChartDate),
            let startOfWeek = Date.startOfWeek(from: weekChartDate) else { return }
            
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
            (1...7).map {
                WeekDayChartElement(
                    amountOfPage: 0,
                    weekDay: Date.getWeekDayInString(from: $0)
                  )
            }
        }

        func getMaxAmountOfPage() -> Int {
            (weekDaysArr.sorted(by: { $0.amountOfPage < $1.amountOfPage }).last?.amountOfPage ?? 30) + 10
        }
        
        func increaseDateAndUpdateChart(with readingSessions: [QuranReadingSession]) {
            weekChartDate = Date(timeIntervalSince1970: weekChartDate.timeIntervalSince1970 + Date.weekInSeconds)
            getWeekStatArr(from: readingSessions)
        }
        
        func decreaseDateAndUpdateChart(with readingSessions: [QuranReadingSession]) {
            weekChartDate = Date(timeIntervalSince1970: weekChartDate.timeIntervalSince1970 - Date.weekInSeconds)
            getWeekStatArr(from: readingSessions)
        }
        
        func getArrayOfCurrentMonthSessions(from allSessions: [QuranReadingSession]) {
            var array: [Int?] = Array(repeating: nil, count: weekChartDate.numberOfDaysInMonth)
            for session in allSessions
            where (session.sessionDate.yearInt, session.sessionDate.monthInt) ==
            (monthChartDate.yearInt, monthChartDate.monthInt) {
                if array[session.sessionDate.dayInt-1] != nil {
                    array[session.sessionDate.dayInt-1]! += session.pageAmount
                } else {
                    array[session.sessionDate.dayInt-1] = session.pageAmount
                }
            }
            currentMonthSessions = array
        }
    }
}

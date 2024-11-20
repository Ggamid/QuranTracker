//
//  StatView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import SwiftUI
import SwiftData
import Charts

struct StatView: View {

    @Query(sort: \QuranReadingSession.sessionDate) var readingSessions: [QuranReadingSession]
    @State var date: Date = .now
    @State var weekDaysArr: [WeekDayChartElement] = []

    var body: some View {
        NavigationStack {
            VStack {

                weekChartView

                Image(.quranTrackerLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding(.vertical, 20)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SessionsList()
                    } label: {
                        Image(systemName: "book.pages")
                            .foregroundStyle(.orangeQT)
                    }
                }
            }
        }
        .onAppear(perform: {
            getWeekStatArr(from: readingSessions, date: date)
        })
    }
}

#Preview {
    StatView()
}

private extension StatView {
    func getWeekStatArr(from readingSessions: [QuranReadingSession], date: Date) {

        let currentWeekDay = Calendar.current.component(.weekday, from: date)
        let daysInSeconds = Double((currentWeekDay*(60*60*24)))

        let thisWeekReadingSessions = readingSessions.filter {
            $0.sessionDate.timeIntervalSince1970 >= date.timeIntervalSince1970 - daysInSeconds
        }

        var weekStatArr: [WeekDayChartElement] = generateArrForWeekStat()

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
        (weekDaysArr.sorted(by: { first, second in
            first.amountOfPage < second.amountOfPage
        }).last?.amountOfPage ?? 30) + 10
    }

    @ViewBuilder
    var weekChartView: some View {
        if !weekDaysArr.isEmpty {
            Text("Недельная статистика чтения")
                .font(.title2)
                .fontWeight(.medium)
            Text("Всего прочтено страниц: \(weekDaysArr.reduce(0, {$0 + $1.amountOfPage}))")

            Chart {
                ForEach(weekDaysArr) { weekDayStat in
                    BarMark(
                        x: .value("WeekDay", weekDayStat.weekDay),
                        y: .value("Pages", weekDayStat.amountOfPage)
                    )
                    .foregroundStyle(.yellowQT.gradient)
                    .annotation(position: .top) {
                        Text("\(weekDayStat.amountOfPage)")
                    }
                }
            }
            .frame(height: 220)
            .chartYScale(domain: 0...getMaxAmountOfPage())
            .padding()
        }
    }
}

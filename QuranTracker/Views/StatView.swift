//
//  StatView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import SwiftUI
import SwiftData
import SwiftfulUI
import Charts

struct StatView: View {

    @Query(sort: \QuranReadingSession.sessionDate) var readingSessions: [QuranReadingSession]

    @State var date: Date = .now
    @State var weekDaysArr: [WeekDayChartElement] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    stats
                }
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

    return StatView()
        .modelContainer(PreviewMockSwiftData.previewContainer)
}

private extension StatView {

    @ViewBuilder
    var stats: some View {
        if !readingSessions.isEmpty {
            progressInPages
            weekChartView
        } else {
            Text("Запишите свой первый прогресс чтобы увидеть статистику чтения!")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            Image(.quranTrackerLogo)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding(.vertical, 20)
        }
    }

    var progressInPages: some View {
        VStack {
            Text("Прогресс в страницах")
                .font(.title2)
                .fontWeight(.bold)

            HStack {
                Text("0")
                Spacer()
                Text("604")
            }
            .font(.title2)
            .frame(maxWidth: .infinity)

            CustomProgressBar(
                selection: Double(readingSessions.last?.endPage ?? 0),
                range: 0...605,
                backgroundColor: .black,
                foregroundColor: .orangeQT,
                cornerRadius: 10,
                height: 8
            )
        }
        .padding()
        .background(.yellowQT)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }

    func getWeekStatArr(from readingSessions: [QuranReadingSession], date: Date) { // для получения сессий чтения для текущей недели

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

    @ViewBuilder
    var weekChartView: some View {
        if !weekDaysArr.isEmpty {
            headerOfChartView

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
    
    @ViewBuilder
    var headerOfChartView: some View {
        VStack(alignment: .leading) {
            Text("Недельная статистика чтения")
                .font(.title2)
                .fontWeight(.medium)
            Text("Всего прочтено страниц: \(weekDaysArr.reduce(0, {$0 + $1.amountOfPage}))")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)

        HStack(spacing: 30) {

            Text("\(Date.getStartAndEndOfWeek(from: date))")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)

            Button {
                date = Date(timeIntervalSince1970: date.timeIntervalSince1970 - Date.weekInSeconds)
                getWeekStatArr(from: readingSessions, date: date)
            } label: {
                Image(systemName: "chevron.left")
            }

            Button {
                date = Date(timeIntervalSince1970: date.timeIntervalSince1970 + Date.weekInSeconds)
                getWeekStatArr(from: readingSessions, date: date)
            } label: {
                 Image(systemName: "chevron.right")
            }
            .padding(.trailing)

        }
        .font(.title)
        .padding(5)
    }
}

//
//  CalendarVIew.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 05.12.2024.
//

import SwiftUI

struct CalendarView: View {
    @Binding var date: Date
    let currentDate = Date.now
    let readingSessions: [Int?]
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    @State private var days: [Date] = []
    
    var body: some View {
        VStack {
            increaseDecreaseDateView
            
            HStack {
                ForEach(1...7, id: \.self) { index in
                    Text(Date.getWeekDayInString(from: index))
                        .fontWeight(.black)
                        .foregroundStyle(Color.additionalYellow)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                        Date.now.startOfDay == day.startOfDay
                                        ? .red.opacity(0.5)
                                        :  .additionalYellow.opacity(0.5)
                                    )
                            )
                            .overlay(alignment: .bottomTrailing) {
                                if let sumOfReadedPages = readingSessions[day.dayInt-1] {
                                    Circle()
                                        .frame(height: 17)
                                        .foregroundStyle(.green)
                                        .overlay {
                                            Text("\(sumOfReadedPages)")
                                                .font(.caption2)
                                        }
                                }
                            }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
    }
    
//    func getSumOfPages(from date: Date) -> Int {
//        readingSessions.compactMap({$0}).filter { quranReadingSession in
//            quranReadingSession.sessionDate.dayInt == date.dayInt
//        }.reduce(0) { $0 + $1.pageAmount }
//    }
    
    func increaseDateAndUpdateMonthChart() {
        date = Date(
            timeIntervalSince1970: date.timeIntervalSince1970 + Double(date.numberOfDaysInMonth) * Date.dayInSeconds
        )
    }
    
    func decreaseDateAndUpdateMonthChart() {
        date = Date(
            timeIntervalSince1970: date.timeIntervalSince1970 - Double(date.numberOfDaysInMonth) * Date.dayInSeconds
        )
    }
    
    func isCurrentMonth() -> Bool {
        (currentDate.monthInt, currentDate.yearInt) == (date.monthInt, date.yearInt)
    }
    
    func getMonthName(by number: Int) -> String {
        let months = [
            1: "Январь ❄️",
            2: "Февраль ❄️",
            3: "Март 🌼",
            4: "Апрель 🌼",
            5: "Май 🌼",
            6: "Июнь ☀️",
            7: "Июль ☀️",
            8: "Август ☀️",
            9: "Сентябрь 🍂",
            10: "Октябрь 🍂",
            11: "Ноябрь 🍂",
            12: "Декабрь ❄️"
        ]
        return months[number] ?? " "
    }
    
    private var increaseDecreaseDateView: some View {
        HStack(spacing: 30) {
            VStack {
                Text("\(date.yearInt)".replacing(" ", with: ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                Text(getMonthName(by: date.monthInt))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading)
            Button {
                withAnimation {
                    decreaseDateAndUpdateMonthChart()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.additionalYellow)
                    .bold()
            }
            
            Button {
                withAnimation {
                    increaseDateAndUpdateMonthChart()
                }
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(!(isCurrentMonth()) ? .additionalYellow : .gray.opacity(0.3))
                    .bold()
            }
            .allowsHitTesting(!(isCurrentMonth()))
            .padding(.trailing)
        }
        .padding(.bottom)
        .font(.title)
    }
    
}

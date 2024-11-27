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

    @State var vm = ViewModel()

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
            vm.getWeekStatArr(from: readingSessions, date: vm.date)
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

    @ViewBuilder
    var weekChartView: some View {
        if !vm.weekDaysArr.isEmpty {
            headerOfChartView

            Chart {
                ForEach(vm.weekDaysArr) { weekDayStat in
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
            .chartYScale(domain: 0...vm.getMaxAmountOfPage())
            .padding()
        }
    }

    @ViewBuilder
    var headerOfChartView: some View {
        VStack(alignment: .leading) {
            Text("Недельная статистика чтения")
                .font(.title2)
                .fontWeight(.medium)
            Text("Всего прочтено страниц: \(vm.weekDaysArr.reduce(0, {$0 + $1.amountOfPage}))")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)

        HStack(spacing: 30) {

            Text("\(Date.getStartAndEndOfWeek(from: vm.date))")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)

            Button {
                withAnimation {
                    vm.decreaseDateAndUpdateChart(with: readingSessions)
                }
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.yellowQT)
            }

            Button {
                withAnimation {
                    vm.increaseDateAndUpdateChart(with: readingSessions)
                }
            } label: {
                 Image(systemName: "chevron.right")
                    .foregroundStyle(!(vm.isCurrentWeek) ? .yellowQT : .gray.opacity(0.3))
            }
            .allowsHitTesting(!(vm.isCurrentWeek))
            .padding(.trailing)

        }
        .font(.title)
        .padding(5)
    }
}

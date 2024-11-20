//
//  StatView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import SwiftUI
import SwiftData
import SwiftfulUI

struct StatView: View {

    @Query(sort: \QuranReadingSession.sessionDate) var readingSessions: [QuranReadingSession]

    var body: some View {
        NavigationStack {
            VStack {
                progressInPages

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
    }
}

#Preview {
    StatView()
}

private extension StatView {
    @ViewBuilder
    var progressInPages: some View {
        if !readingSessions.isEmpty {
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
        } else {
            Text("Запишите свой первый прогресс чтобы увидеть статистику чтения!")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

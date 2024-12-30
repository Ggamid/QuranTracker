//
//  SessionsList.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import SwiftUI
import SwiftData

struct SessionsList: View {
    @Query(sort: \QuranReadingSession.sessionDate) var readingSessions: [QuranReadingSession]
    @Environment(\.modelContext) var modelContext
    @Binding var updateChart: Bool

    @State private var selections = Set<QuranReadingSession>()

    var body: some View {
        List(readingSessions, selection: $selections) { session in
            SessionsListRow(
                date: session.stringDate,
                pageAmount: session.pageAmount,
                startPage: session.startPage,
                endPage: session.endPage
            )
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .swipeActions {
                Button("Delete", systemImage: "trash") {
                    modelContext.delete(session)
                    updateChart.toggle()
                }
                .tint(.red)
            }
            .tag(session)
        }
        .toolbar {
            if !selections.isEmpty {
                ToolbarItem {
                    Button(role: .destructive) {
                        for session in selections {
                            modelContext.delete(session)
                            updateChart.toggle()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .tint(.red)
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
    }
}

#Preview {
    SessionsList(updateChart: .constant(false))
}

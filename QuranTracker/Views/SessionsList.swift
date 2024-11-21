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
    #if DEBUG
    @Environment(\.modelContext) var modelContext
    #endif
    var body: some View {
        ScrollView {
            ForEach(readingSessions) { session in
                SessionsListRow(
                    date: session.stringDate,
                    pageAmount: session.pageAmount,
                    startPage: session.startPage,
                    endPage: session.endPage
                )
            }
        }
        #if DEBUG
        .toolbar {
            ToolbarItem {
                Button {
                    for session in readingSessions {
                        modelContext.delete(session)
                    }
                } label: {
                    Image(systemName: "trash")
                }

            }
        }
        #endif
    }
}

#Preview {
    SessionsList()
}

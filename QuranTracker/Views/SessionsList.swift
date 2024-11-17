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

    var body: some View {
        ScrollView {
            ForEach(readingSessions) { session in
                HStack {
                    Text(session.getStringDate())
                    Text("\(session.pageAmount)")
                }
            }
        }
    }
}

#Preview {
    SessionsList()
}

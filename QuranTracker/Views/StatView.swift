//
//  StatView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import SwiftUI

struct StatView: View {
    var body: some View {
        NavigationStack {
            VStack {
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

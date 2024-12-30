//
//  ContentView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 10.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StatView()
                .tabItem { Image(systemName: "chart.xyaxis.line") }
            RewardsView()
                .tabItem { Image(systemName: "medal") }
        }
    }
}

#Preview {
    ContentView()
}

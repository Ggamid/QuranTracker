//
//  HomeView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 10.11.2024.
//

import SwiftUI
import SwiftfulUI

struct HomeView: View {

    @State private var writeProgressOffset: Int = 0
    @State private var blurRadius: CGFloat = 7
    @State private var isNextScreenActive = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    header

                    Image(.quranTrackerLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .padding(.vertical, 20)

                    Spacer()
                        .frame(maxHeight: 100)

                    ButtonQT {
                        withAnimation(.bouncy) {
                            writeProgressOffset = 0
                            blurRadius = 7
                        }
                    }
                    .padding(.horizontal)

                    ButtonQT(text: "Статистика") {
                        isNextScreenActive = true
                    }
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                .blur(radius: blurRadius)
                WriteProgressView {
                    withAnimation {
                        writeProgressOffset = 1000
                        blurRadius = 0
                    }
                }
                .offset(y: CGFloat(writeProgressOffset))
            }
            .navigationDestination(isPresented: $isNextScreenActive) {
                StatView()
            }
        }
    }
}

#Preview {
    HomeView()
}

extension HomeView {
    private var header: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(.yellowQT)
                .blur(radius: 7)

            HStack {
                Particles()
                Text("Quran Tracker")
                    .font(.system(size: 27))
                    .fontWeight(.black)
                    .lineLimit(1)
                Particles()
            }
        }
        .frame(maxHeight: 90)
        .padding(.horizontal)
    }
}

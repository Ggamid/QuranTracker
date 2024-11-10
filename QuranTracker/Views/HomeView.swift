//
//  HomeView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 10.11.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            header
            
            Image(.quranTrackerLogo)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding(.vertical, 20)
            
            Spacer()
                .frame(maxHeight: 100)
            
            ButtonQT()
                .padding(.horizontal)
            ButtonQT(text: "Статистика")
                .padding(.horizontal)
                .padding(.bottom)
        }
    }
}

#Preview {
    HomeView()
}


extension HomeView {
    private var header: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 100)
                .fill(.yellowQT)
                .blur(radius: 7)
            HStack{
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

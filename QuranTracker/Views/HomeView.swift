//
//  HomeView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 10.11.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var writeProgressOffset: Int = 1000
    @State var blurRadius: CGFloat = 0
    
    var body: some View {
        ZStack{
            VStack{
                header
                
                Image(.quranTrackerLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding(.vertical, 20)
                
                Spacer()
                    .frame(maxHeight: 100)
                
                ButtonQT(){
                    withAnimation(.bouncy) {
                        writeProgressOffset = 0
                        blurRadius = 7
                    }
                }
                    .padding(.horizontal)
                
                ButtonQT(text: "Статистика")
                    .padding(.horizontal)
                    .padding(.bottom)
                
            }
            .blur(radius: blurRadius)
            
            WriteProgressView(){
                withAnimation {
                    writeProgressOffset = 1000
                    blurRadius = 0
                }
            } onSavePressed: { }
            .offset(y:CGFloat(writeProgressOffset))
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

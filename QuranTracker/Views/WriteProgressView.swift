//
//  WriteProgressView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 10.11.2024.
//

import SwiftUI

struct WriteProgressView: View {
    
    @State var dateOfReading: Date = .now
    @State var fromPage: Int = 0
    @State var toPage: Int = 0
    
    @FocusState private var amountIsFouced: Bool
    
    var onXmarkPressed: (() -> Void)? = nil
    var onSavePressed: (() -> Void)? = nil
    
    var body: some View {
        ZStack{
            
            Color.white.opacity(0.7)
                .onTapGesture {
                    amountIsFouced = false
                }
                .overlay(alignment: .topTrailing) { xmark }
            
            VStack(){
                
                header
                
                claimDate
                    .padding(.horizontal)
                
                claimFromPage
                    .padding(.horizontal)

                claimToPage
                    .padding(.horizontal)
                    .padding(.bottom)
                
                ButtonQT(text: "Сохранить") { 
                    onSavePressed?()
                    onXmarkPressed?()
                }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
     
            }
            .frame(maxWidth: 350)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .shadow(radius: 20)
        }
    }
}

#Preview {
    ZStack{
        HomeView()
            .blur(radius: 6)
        WriteProgressView()
    }
}

extension WriteProgressView {
    private var header: some View {
        HStack{
            VStack(alignment: .leading, spacing: -9){
                Text("Запись")
                Text("Прогресса")
            }
            .frame(width: 200)
            .font(.title)
            .fontWeight(.black)
            .offset(x: -20)
            
            Spacer()
            
            Image(.quranTrackerLogo)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
        }
        .padding()
    }
    
    private var claimDate: some View {
        HStack{
            Text("Дата")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)

            DatePicker("", selection: $dateOfReading, displayedComponents: .date)
        }
    }
    
    private var claimFromPage: some View {
        HStack{
            Text("От")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("", value: $fromPage, format: .number)
                .focused($amountIsFouced)
                .keyboardType(.numberPad)
                .frame(maxWidth: 30)
        }
    }
    
    private var xmark: some View{
        Circle()
            .fill(.yellowQT)
            .frame(height: 50)
            .padding()
            .overlay {
                Image(systemName: "xmark")
                    .font(.title2)
            }
            .onTapGesture {
                onXmarkPressed?()
            }
    }
    
    private var claimToPage: some View {
        HStack{
            Text("До")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("", value: $toPage, format: .number)
                .focused($amountIsFouced)
                .keyboardType(.numberPad)
                .frame(maxWidth: 30)
        }
    }
}

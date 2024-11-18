//
//  WriteProgressView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 10.11.2024.
//

import SwiftUI
import Vortex
import SwiftfulUI
import SwiftData

struct WriteProgressView: View {

    @Query(sort: \QuranReadingSession.sessionDate) var readingSessions: [QuranReadingSession]
    @Environment(\.modelContext) var modelContext
    @FocusState private var amountIsFouced: Bool
    @State var vm = ViewModel()

    var onXmarkPressed: (() -> Void)?

    var body: some View {
        ZStack {
            Color.white.opacity(0.7)
                .onTapGesture {
                    amountIsFouced = false
                }
                .overlay(alignment: .topTrailing) { xmark }

            VortexViewReader { proxy in
                ZStack {
                    vortexView

                    VStack {
                        currentPosition

                        VStack {
                            header

                            claimDate
                                .padding(.horizontal)
                            claimFromPage
                                .padding(.horizontal)
                            claimToPage
                                .padding(.horizontal)
                                .padding(.bottom)

                            ButtonQT(text: "Сохранить") {

                                if vm.saveReadingSession(modelContext: modelContext) {
                                    proxy.burst()
                                    Task {
                                        guard let lastReadingSession = readingSessions.last else { return }
                                        await vm.getSurahName(quranReadingSession: lastReadingSession)
                                    }

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { onXmarkPressed?() }
                                    amountIsFouced = false
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        }
                        .frame(maxWidth: 350)
                        .background(.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .shadow(radius: 20)
                    }
                }
            }
        }
        .onAppear {
            Task {
                guard let lastReadingSession = readingSessions.last else { return }
                await vm.getSurahName(quranReadingSession: lastReadingSession)
            }
        }
        .alert(
            "Проверьте корректность введенных данных",
            isPresented: $vm.presentAlert) {
                Button("Ok") {
                    vm.presentAlert = false
                }
            } message: {
                Text("Проверьте корректность введенных данных")
            }
    }
}

#Preview {
    ZStack {
        HomeView()
            .blur(radius: 6)

        WriteProgressView()
    }
}

extension WriteProgressView {

    private var vortexView: some View {
        VortexView(.confetti) {
            Rectangle()
                .fill(.white)
                .frame(width: 16, height: 16)
                .tag("square")
            Circle()
                .fill(.white)
                .frame(width: 16)
                .tag("circle")
        }
        .allowsHitTesting(false)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: -9) {
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
        HStack {
            Text("Дата")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)

            DatePicker("", selection: $vm.sessionDate, in: ...Date(), displayedComponents: .date)
                .tint(.yellowQT)
        }
    }
    private var claimFromPage: some View {
        HStack {
            Text("От")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("", value: $vm.startPage, format: .number)
                .focused($amountIsFouced)
                .keyboardType(.numberPad)
                .frame(maxWidth: 30)
        }
    }
    private var xmark: some View {
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
        HStack {
            Text("До")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("", value: $vm.endPage, format: .number)
                .focused($amountIsFouced)
                .keyboardType(.numberPad)
                .frame(maxWidth: 30)
        }
    }
    private var currentPosition: some View {
        VStack {
            if let currentPage = vm.currentPage, let currentSurah = vm.currentSurah {
                Text("Текущая позиция")
                    .font(.title2)
                    .fontWeight(.bold)
                HStack {
                    VStack {
                        Text("страница.")
                        Text("\(currentPage)")
                    }
                    VStack {
                        Text("Сура")
                        Text(currentSurah)
                    }
                }
            }
        }
        .frame(height: 100)
    }
}

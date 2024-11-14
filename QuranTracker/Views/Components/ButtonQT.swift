//
//  Button.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 10.11.2024.
//

import SwiftUI
import SwiftfulUI

struct ButtonQT: View {
    var text: String?
    var onTap: (() -> Void)?

    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(.yellowQT)
            .frame(height: 70)
            .shadow(radius: 10)
            .overlay {
                HStack {
                    Particles()
                    Spacer()

                    Group {
                        if let text {
                            Text(text)
                                .font(.title)
                                .fontWeight(.black)
                        } else {
                            VStack(spacing: 0) {
                                Text("Записать")
                                    .offset(y: 5)
                                Text("прогресс")
                                    .offset(y: -7)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .font(.title)
                    .fontWeight(.black)

                    Spacer()
                    Particles()
                }
                .padding(.horizontal)
            }
            .asButton(.press) {
                onTap?()
            }
    }
}

#Preview {
    VStack {
        ButtonQT()
            .padding(.horizontal)
        ButtonQT(text: "Сохранить")
            .padding(.horizontal)
        ButtonQT(text: "Статистика")
            .padding(.horizontal)
    }
}

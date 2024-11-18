//
//  ButtonScaleModifier.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import SwiftUI

struct ButtonScaleModifier: ViewModifier {
    @State private var isPressed: Bool = false
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.9 : 1.0) // Уменьшение размера при нажатии
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed) // Анимация
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        withAnimation {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            isPressed = false
                        }
                    }
            )
            .onTapGesture {
                withAnimation {
                    isPressed.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isPressed = false
                }
        }
    }
}

extension View {
    func scalableButton() -> some View {
        self.modifier(ButtonScaleModifier())
    }
}

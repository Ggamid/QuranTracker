//
//  SwiftUIView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 10.11.2024.
//

import SwiftUI

struct Particles: View {
    var body: some View {
        Image(.particles)
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
    }
}

#Preview {
    Particles()
}

//
//  SessionsListRow.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 17.11.2024.
//

import SwiftUI

struct SessionsListRow: View {
    @State var showPopover = false
    let date: String
    let pageAmount: Int
    let startPage: Int
    let endPage: Int

    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundStyle(.orangeQT)
            Text(date)
            Image(systemName: "book.pages")
                .foregroundStyle(.orangeQT)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text("\(pageAmount)")
        }
        .font(.title)
        .lineLimit(1)
        .padding()
        .onTapGesture {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover, content: {
            ZStack {
                Color.white
                HStack {
                    VStack {
                        Text("Первая стр.")
                        Text("\(startPage)")
                    }
                    VStack {
                        Text("Послендняя стр.")
                        Text("\(endPage)")
                    }
                }
                .padding(.horizontal)
            }
            .presentationCompactAdaptation(.popover)
        })
    }
}

#Preview {
    SessionsListRow(
        date: "20-11-24",
        pageAmount: 10,
        startPage: 12,
        endPage: 20
    )
}

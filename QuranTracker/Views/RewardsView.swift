//
//  RewardsView.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 09.12.2024.
//

import SwiftUI
import SwiftfulUI

struct RewardsView: View {

    @State var isSmallHeader = false
    var body: some View {
        VStack {
            
            Text("Хадисы о достоинстве Корана и его чтении 📖")
                .bold()
                .multilineTextAlignment(.leading)
                .font(isSmallHeader ? .title3 : .title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .foregroundStyle(.black)
            
            ScrollView {
                
                ForEach(Hadith.hadiths, id: \.text) { hadith in
                    ExpandableView(
                        label: hadith.label,
                        text: hadith.text,
                        author: hadith.author,
                        source: hadith.source
                    )
                }
            }
        }
    }
}

#Preview {
    RewardsView()
}

private extension RewardsView {
    struct ExpandableView: View {
        @State private var isExpanded = false
        let label: String
        let text: String
        let author: String
        let source: String
        
        var body: some View {
            VStack {
                HStack {
                    Text(label)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.orange)
                        .rotationEffect(!isExpanded ? .zero : Angle(degrees: -180))
                        .padding(7)
                        .onTapGesture {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }
                }
                .padding()
                
                VStack {
                    if isExpanded {
                        VStack {
                            Group {
                                Text(author)
                                Text("“\(text)“")
                                    .font(.title3)
                                Text(source)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(4)
                        }
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
                    }
                }
                .frame(maxWidth: .infinity)
                .clipped()
            }
        }
    }
}

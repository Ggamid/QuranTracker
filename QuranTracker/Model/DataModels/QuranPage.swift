//
//  QuranPage.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 12.11.2024.
//

import Foundation


struct DataWrapper: Codable {
    let data: QuranPage
}


// MARK: - QuranPage
struct QuranPage: Codable {
    let number: Int
    let surahs: [String: Surah]
    
    static let mock = QuranPage(
        number: 2,
        surahs: ["2" : .mock]
    )
}

// MARK: - Surah
struct Surah: Codable {
    let number: Int
    let englishName: String
    
    static let mock = Surah(
        number: 2,
        englishName: "Al-Baqara"
    )
}

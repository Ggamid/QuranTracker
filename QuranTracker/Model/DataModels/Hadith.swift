//  Hadith.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 09.12.2024.
//

import Foundation

struct Hadith: Codable {
    var uid = UUID().uuidString
    let label: String
    let author: String
    let text: String
    let source: String
    let additionalInfo: String?
    let tags: [String]?
}

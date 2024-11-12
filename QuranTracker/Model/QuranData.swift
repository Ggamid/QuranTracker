//
//  QuranData.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 12.11.2024.
//

import Foundation

class QuranData {
    static func fetchData(about page: Int) async throws -> QuranPage {
        
        guard page >= 1 || page <= 604 else { throw FetchingDataError.invalidPageNumber }
        
        guard let url = URL(string: "https://api.alquran.cloud/v1/page/\(page)") else { throw FetchingDataError.invalidURL }
        
        print(url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // CHECK RESPONSE
            throw FetchingDataError.InvalidResponse
        }
        
        do{
            let quranPage = try JSONDecoder().decode(DataWrapper.self, from: data) // TRY TO DECODE DATA
            return quranPage.data
        } catch {
            print(error)
            throw FetchingDataError.InvalidData
        }
        
    }
    

}

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

enum FetchingDataError: Error {
    case invalidPageNumber, invalidURL, errorWhileDecodingData, InvalidResponse, InvalidData
}

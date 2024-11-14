//
//  QuranData.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 12.11.2024.
//

import Foundation

class QuranData {
    static func fetchData(about page: Int) async throws -> QuranPage {
        guard (1..<605).contains(page) else { throw FetchingDataError.invalidPageNumber }
        guard let url = URL(
            string: "https://api.alquran.cloud/v1/page/\(page)"
        )

        else {
            throw FetchingDataError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            // CHECK RESPONSE
            throw FetchingDataError.invalidResponse
        }

        do {
            let quranPage = try JSONDecoder().decode(DataWrapper.self, from: data) // TRY TO DECODE DATA
            return quranPage.data
        } catch {
            throw FetchingDataError.invalidData
        }
    }
}

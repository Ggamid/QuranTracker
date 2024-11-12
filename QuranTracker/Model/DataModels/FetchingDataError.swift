//
//  FetchingDataError.swift
//  QuranTracker
//
//  Created by Gamıd Khalıdov on 12.11.2024.
//

import Foundation

enum FetchingDataError: Error {
    case invalidPageNumber
    case invalidURL
    case errorWhileDecodingData
    case InvalidResponse
    case InvalidData
}

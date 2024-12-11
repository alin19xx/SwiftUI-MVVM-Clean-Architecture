//
//  NetworkError.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError(DecodingError)
    case networkError(URLError)
    case unknownError
}

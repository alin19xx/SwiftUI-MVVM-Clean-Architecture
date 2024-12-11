//
//  CryptoListRepositoryError.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

enum CryptoRepositoryError: Error {
    case invalidURL
    case decodingError(Error)
    case networkError(Error)
}

private func handleError(_ error: Error) -> Error {
    if let urlError = error as? URLError {
        return CryptoRepositoryError.networkError(urlError)
    } else if let decodingError = error as? DecodingError {
        return CryptoRepositoryError.decodingError(decodingError)
    } else {
        return error
    }
}

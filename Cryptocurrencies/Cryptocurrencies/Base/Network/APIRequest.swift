//
//  APIRequest.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

struct APIRequest {
    let baseURL: String
    let path: String?
    let queryItems: [URLQueryItem]
    
    func url() throws -> URL {
        guard var components = URLComponents(string: baseURL) else {
            throw CryptoRepositoryError.invalidURL
        }
        
        components.path += path ?? ""
        components.queryItems = queryItems
        guard let url = components.url else {
            throw CryptoRepositoryError.invalidURL
        }
        
        return url
    }
}

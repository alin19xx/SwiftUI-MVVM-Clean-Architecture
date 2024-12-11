//
//  CryptoDecodable.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

struct CryptoDecodable: Decodable, Identifiable {
    let id: Int
    let name: String
    let symbol: String
    var logoUrl: String?
    let quote: [String: QuoteDecodable]
}

struct QuoteDecodable: Decodable {
    let price: Double
    let percentChange1h: Double
    
    enum CodingKeys: String, CodingKey {
        case price, percentChange1h = "percent_change_1h"
    }
}



struct CryptoResponse: Decodable {
    let data: [CryptoDecodable]
}

struct CryptoInfoResponse: Decodable {
    let data: [String: CryptoDetails]
}

struct CryptoDetails: Decodable {
    let logo: String?
}

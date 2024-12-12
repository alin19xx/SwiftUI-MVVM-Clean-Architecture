//
//  CryptoDecodable.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

struct CryptoListDecodable: Decodable {
    let data: [CryptoDecodable]
}

struct CryptoDecodable: Decodable, Identifiable {
    let id: Int
    let name: String
    let symbol: String
    var logoUrl: String?
    let quote: [String: QuoteDecodable]
}

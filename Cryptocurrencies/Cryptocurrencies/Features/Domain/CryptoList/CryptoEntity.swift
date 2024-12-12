//
//  CryptoEntity.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

struct CryptoEntity {
    let id: Int
    let name: String
    let symbol: String
    let logoUrl: String?
    let description: String?
    let website: [String]
    let technicalDoc: [String]
    let explorer: [String]
    let price: Double
    let volume24h: Double
    let volumeChange24h: Double
    let percentChange1h: Double
    let percentChange24h: Double
    let percentChange7d: Double
    let marketCap: Double
    
    init(crypto: CryptoDecodable, details: CryptoDetailsDecodable? = nil) {
        self.id = crypto.id
        self.name = crypto.name
        self.symbol = crypto.symbol
        self.logoUrl = details?.logo ?? crypto.logoUrl
        self.description = details?.description
        self.website = details?.urls?.website ?? []
        self.technicalDoc = details?.urls?.technicalDoc ?? []
        self.explorer = details?.urls?.explorer ?? []
        
        if let usdQuote = crypto.quote["USD"] {
            self.price = usdQuote.price
            self.volume24h = usdQuote.volume24h
            self.volumeChange24h = usdQuote.volumeChange24h
            self.percentChange1h = usdQuote.percentChange1h
            self.percentChange24h = usdQuote.percentChange24h
            self.percentChange7d = usdQuote.percentChange7d
            self.marketCap = usdQuote.marketCap
        } else {
            self.price = 0.0
            self.volume24h = 0.0
            self.volumeChange24h = 0.0
            self.percentChange1h = 0.0
            self.percentChange24h = 0.0
            self.percentChange7d = 0.0
            self.marketCap = 0.0
        }
    }
}

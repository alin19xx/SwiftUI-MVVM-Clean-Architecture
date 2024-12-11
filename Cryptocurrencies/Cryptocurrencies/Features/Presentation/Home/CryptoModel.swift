//
//  CryptoModel.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation
import SwiftData

@Model
final class CryptoModel {
    
    @Attribute(.unique) var id: Int
    var name: String
    var symbol: String
    var logoUrl: String?
    var quotePriceUSD: Double
    var quotePercentChange1hUSD: Double
    var isFavorite: Bool

    init(id: Int, name: String, symbol: String, logoUrl: String?, quotePriceUSD: Double, quotePercentChange1hUSD: Double, isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.logoUrl = logoUrl
        self.quotePriceUSD = quotePriceUSD
        self.quotePercentChange1hUSD = quotePercentChange1hUSD
        self.isFavorite = isFavorite
    }
    
    
    init(crypto: CryptoDecodable, isFavorite: Bool = false) {
        self.id = crypto.id
        self.name = crypto.name
        self.symbol = crypto.symbol
        self.logoUrl = crypto.logoUrl
        self.isFavorite = isFavorite
        if let usdQuote = crypto.quote["USD"] {
            self.quotePriceUSD = usdQuote.price
            self.quotePercentChange1hUSD = usdQuote.percentChange1h
        } else {
            self.quotePriceUSD = 0.0
            self.quotePercentChange1hUSD = 0.0
        }
    }
}

@Model
final class QuoteModel {
    let price: Double
    let percentChange1h: Double
    
    init(quote: QuoteDecodable) {
        self.price = quote.price
        self.percentChange1h = quote.percentChange1h
    }
}

//
//  QuoteDecodable.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

struct QuoteDecodable: Decodable {
    let price: Double
    let percentChange1h: Double
    let percentChange24h: Double
    let percentChange7d: Double
    let volume24h: Double
    let volumeChange24h: Double
    let marketCap: Double
    
    enum CodingKeys: String, CodingKey {
        case price
        case percentChange1h = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d = "percent_change_7d"
        case volume24h = "volume_24h"
        case volumeChange24h = "volume_change_24h"
        case marketCap = "market_cap"
    }
}

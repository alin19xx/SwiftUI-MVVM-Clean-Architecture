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
    var desc: String?
    var website: [URLModel]
    var technicalDoc: [URLModel]
    var explorer: [URLModel]
    var price: Double
    var volume24h: Double
    var volumeChange24h: Double
    var percentChange1h: Double
    var percentChange24h: Double
    var percentChange7d: Double
    var marketCap: Double
    var isFavorite: Bool = false

    init(
        id: Int,
        name: String,
        symbol: String,
        logoUrl: String?,
        desc: String?,
        website: [String],
        technicalDoc: [String],
        explorer: [String],
        price: Double,
        volume24h: Double,
        volumeChange24h: Double,
        percentChange1h: Double,
        percentChange24h: Double,
        percentChange7d: Double,
        marketCap: Double,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.logoUrl = logoUrl
        self.desc = desc
        self.website = website.map { URLModel(url: $0) }
        self.technicalDoc = technicalDoc.map { URLModel(url: $0) }
        self.explorer = explorer.map { URLModel(url: $0) }
        self.price = price
        self.volume24h = volume24h
        self.volumeChange24h = volumeChange24h
        self.percentChange1h = percentChange1h
        self.percentChange24h = percentChange24h
        self.percentChange7d = percentChange7d
        self.marketCap = marketCap
    }
    
    init(from entity: CryptoEntity, isFavorite: Bool = false) {
        self.id = entity.id
        self.name = entity.name
        self.symbol = entity.symbol
        self.logoUrl = entity.logoUrl
        self.desc = entity.description
        self.website = entity.website.map { URLModel(url: $0) }
        self.technicalDoc = entity.technicalDoc.map { URLModel(url: $0) }
        self.explorer = entity.explorer.map { URLModel(url: $0) }
        self.price = entity.price
        self.volume24h = entity.volume24h
        self.volumeChange24h = entity.volumeChange24h
        self.percentChange1h = entity.percentChange1h
        self.percentChange24h = entity.percentChange24h
        self.percentChange7d = entity.percentChange7d
        self.marketCap = entity.marketCap
        self.isFavorite = isFavorite
    }
}

@Model
final class URLModel {
    @Attribute(.unique) var id: UUID = UUID()
    var url: String

    init(url: String) {
        self.url = url
    }
}

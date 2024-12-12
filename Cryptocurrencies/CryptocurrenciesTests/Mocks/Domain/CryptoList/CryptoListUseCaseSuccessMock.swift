//
//  CryptoListUseCaseSuccessMock.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Foundation
@testable import Cryptocurrencies

class CryptoListUseCaseSuccessMock: CryptoListUseCaseProtocol {
    func execute() async throws -> [CryptoModel] {
        return [
            CryptoModel(
                        id: 1,
                        name: "Bitcoin",
                        symbol: "BTC",
                        logoUrl: "https://bitcoin.org/logo.png",
                        desc: "Bitcoin is a decentralized digital currency.",
                        website: ["https://bitcoin.org"],
                        technicalDoc: ["https://bitcoin.org/whitepaper.pdf"],
                        explorer: ["https://blockchain.com/btc"],
                        price: 45000.0,
                        volume24h: 3000000000.0,
                        volumeChange24h: 2.5,
                        percentChange1h: 0.1,
                        percentChange24h: -0.5,
                        percentChange7d: 5.0,
                        marketCap: 850000000000.0
                    ),
            CryptoModel(
                        id: 1027,
                        name: "Ethereum",
                        symbol: "ETH",
                        logoUrl: "https://ethereum.org/logo.png",
                        desc: "Ethereum is a decentralized platform for smart contracts.",
                        website: ["https://ethereum.org"],
                        technicalDoc: ["https://ethereum.org/whitepaper.pdf"],
                        explorer: ["https://etherscan.io"],
                        price: 3000.0,
                        volume24h: 1500000000.0,
                        volumeChange24h: -1.2,
                        percentChange1h: 0.0,
                        percentChange24h: 1.5,
                        percentChange7d: 10.0,
                        marketCap: 350000000000.0
                    )
        ]
    }
}

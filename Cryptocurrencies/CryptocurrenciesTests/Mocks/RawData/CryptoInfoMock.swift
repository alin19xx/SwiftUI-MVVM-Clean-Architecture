//
//  CryptoInfoMock.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Foundation

struct CryptoInfoMock {
    static func makeJsonMock() -> Data {
        """
        {
            "1": {
                "urls": {
                    "website": ["https://bitcoin.org/"],
                    "technical_doc": ["https://bitcoin.org/bitcoin.pdf"],
                    "explorer": ["https://blockchain.info/"]
                },
                "logo": "https://s2.coinmarketcap.com/static/img/coins/64x64/1.png",
                "id": 1,
                "name": "Bitcoin",
                "symbol": "BTC",
                "slug": "bitcoin",
                "description": "Bitcoin is a digital currency...",
                "tags": ["mineable"],
                "category": "coin"
            },
            "1027": {
                "urls": {
                    "website": ["https://www.ethereum.org/"],
                    "technical_doc": ["https://github.com/ethereum/wiki/wiki/White-Paper"],
                    "explorer": ["https://etherscan.io/"]
                },
                "logo": "https://s2.coinmarketcap.com/static/img/coins/64x64/1027.png",
                "id": 1027,
                "name": "Ethereum",
                "symbol": "ETH",
                "slug": "ethereum",
                "description": "Ethereum is a smart contract platform...",
                "tags": ["mineable"],
                "category": "coin"
            }
        }
        """.data(using: .utf8)!
    }
}

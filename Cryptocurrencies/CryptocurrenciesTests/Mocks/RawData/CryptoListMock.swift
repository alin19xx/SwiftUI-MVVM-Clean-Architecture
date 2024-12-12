//
//  CryptoListMock.swift
//  CryptocurrenciesTests
//
//  Created by Alex Lin Segarra on 12/12/24.
//

import Foundation

struct CryptoListMock {
    static func makeJsonMock() -> Data {
        """
        {
            "data": [
                {
                    "id": 1,
                    "name": "Bitcoin",
                    "symbol": "BTC",
                    "slug": "bitcoin",
                    "quote": {
                        "USD": {
                            "price": 9283.92,
                            "volume_24h": 7155680000,
                            "volume_change_24h": -0.152774,
                            "percent_change_1h": -0.152774,
                            "percent_change_24h": 0.518894,
                            "percent_change_7d": 0.986573,
                            "market_cap": 852164659250.2758
                        }
                    }
                },
                {
                    "id": 1027,
                    "name": "Ethereum",
                    "symbol": "ETH",
                    "slug": "ethereum",
                    "quote": {
                        "USD": {
                            "price": 1283.92,
                            "volume_24h": 7155680000,
                            "volume_change_24h": -0.152774,
                            "percent_change_1h": -0.152774,
                            "percent_change_24h": 0.518894,
                            "percent_change_7d": 0.986573,
                            "market_cap": 158055024432
                        }
                    }
                }
            ]
        }
        """.data(using: .utf8)!
    }

    static func makeErrorMock() -> Error {
        URLError(.badServerResponse)
    }
}

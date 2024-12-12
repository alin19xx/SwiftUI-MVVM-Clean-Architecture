//
//  CryptoDetailsDecodable.swift
//  Cryptocurrencies
//
//  Created by Alex Lin Segarra on 11/12/24.
//

import Foundation

struct CryptoInfoResponse: Decodable {
    let data: [String: CryptoDetailsDecodable]
}

struct CryptoDetailsDecodable: Decodable {
    let id: Int
    let name: String
    let symbol: String
    let category: String?
    let description: String?
    let slug: String?
    let logo: String?
    let subreddit: String?
    let tagNames: [String]?
    let tagGroups: [String]?
    let urls: CryptoURLsDecodable?

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, category, description, slug, logo, subreddit
        case tagNames = "tag-names"
        case tagGroups = "tag-groups"
        case urls
    }
}

struct CryptoURLsDecodable: Decodable {
    let website: [String]?
    let technicalDoc: [String]?
    let explorer: [String]?
    let twitter: [String]?
    let reddit: [String]?
    let facebook: [String]?
    let chat: [String]?
    let messageBoard: [String]?

    enum CodingKeys: String, CodingKey {
        case website, technicalDoc = "technical_doc", explorer, twitter, reddit, facebook, chat
        case messageBoard = "message_board"
    }
}

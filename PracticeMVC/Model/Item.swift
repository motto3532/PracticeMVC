//
//  Item.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/30.
//

import Foundation

struct ItemJson: Codable {
    let name: String?
    let maker: String?
    let image: URL?
}

struct ResultJson: Codable {
    let item: [ItemJson]?
}

struct Okashi: Codable {
    let name: String
    let maker: String
    let image: URL
}

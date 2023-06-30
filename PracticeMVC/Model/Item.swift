//
//  Item.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/30.
//

import Foundation

struct Item: Codable {
    let name: String?
    let maker: String?
    let url: URL?
    let image: URL?
}

struct ResultItems: Codable {
    let items: [Item]?
}

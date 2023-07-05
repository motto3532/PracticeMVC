//
//  Item.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/30.
//

import Foundation

struct Okashi: Codable {
    let name: String
    let maker: String
    let image: URL
}

struct ResponseData: Codable {
    let item: [Okashi]
}

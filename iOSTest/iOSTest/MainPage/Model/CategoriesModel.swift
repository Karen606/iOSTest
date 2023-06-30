//
//  CategoriesModel.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import Foundation

struct CategoriesModel: Codable {
    let сategories: [KitchenCategory]
}

// MARK: - Сategory
struct KitchenCategory: Codable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

//
//  DishesModel.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import Foundation

// MARK: - Welcome
struct DishesModel: Codable {
    let dishes: [Dish]
}

// MARK: - Dish
struct Dish: Codable {
    let id: Int
    let name: String
    let price, weight: Int
    let description: String
    let imageURL: String
    let tegs: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description, tegs
        case imageURL = "image_url"
    }
}

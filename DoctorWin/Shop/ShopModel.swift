//
//  ShopModel.swift
//  DoctorWin
//
//  Created by AHP on 30/06/2565 BE.
//

import Foundation

struct ShopCategoryModel: Codable {
    let name: String
    let image: String?
    
}


struct ShopModel: Codable {
    let id: Int
    let product_name: String
    let product_price: String
    let bookmark: Bool
    let image: String
}

struct ProductDetailsModel: Codable {
    let uploadimage: String
    let product_name: String
    let product_condition: String
    let product_models: String?
    let product_price: String
    let location: String
    let phone: Int
    let description: String
    let profile_name: String
    let profileImage: String?
    let speciality: String
    let image: [ProductImageModel]
    
}

struct ProductImageModel: Codable {
    let image: String?
}

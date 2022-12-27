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
    let id: Int?
    
}
struct ShopCategoryResponseModel: Codable {
    let is_active: Bool
    let shopResponse: [ShopCategoryModel]?
}

struct ShopResponseModel: Codable {
    let is_active: Bool
    let display_status: Int?
    let shopResponse: [ShopModel]?
    
}
struct ShopModel: Codable {
    let id: Int?
    let name: String?
    let price: String?
    let bookmark: Bool?
    let image: String?
    let saler_id: Int?
}
struct ShopDetailsModel: Codable {
    let shopResponse: ProductDetailsModel?
    let is_active: Bool?
    let display_status: Int?
}
struct ProductDetailsModel: Codable {
    let id: Int?
    let name: String?
    let product_condition: String?
    let product_models: String?
    let price: String?
    let location: String?
    let phone: String?
    let description: String?
    let bookmark: Bool?
    let userDetails: PostedUserDetailsModel?
    let image: [ProductImageModel]
}
struct ProductImageModel: Codable {
    let image: String?
}

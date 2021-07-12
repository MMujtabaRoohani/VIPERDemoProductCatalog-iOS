//
//  ProductDetail.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 12/07/2021.
//

import Foundation

// Taking only the fields that are required and ignoring all other.
struct ProductDetail: DTO {
    let productId: Int
    let images: [String]
    let name: String
    let brandName: String
    let finalPrice: String
    let info: [ProductInfo]
    
    // I like to follow camelCasing in my entities
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case name, images, info
        case brandName =  "brand_name"
        case finalPrice = "final_price_sale"
    }
}

struct ProductInfo: DTO {
    var name: String
    var text: String
}

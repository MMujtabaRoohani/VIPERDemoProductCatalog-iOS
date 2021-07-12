//
//  BriefProduct.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

// Taking only the fields that are required and ignoring all other.
struct BriefProduct: DTO {
    let productId: Int
    let thumbnailURL: String
    let name: String
    let vendorName: String
    let finalPrice: String
    
    // I like to follow camelCasing in my entities
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case thumbnailURL = "thumbnail_url"
        case name
        case vendorName =  "vendor_name"
        case finalPrice = "final_price_sale"
    }
}

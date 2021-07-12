//
//  ProductListQuery.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

struct ProductListQuery: DTO {
    var categoryId: Int?
    var page: Int?
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case page
    }
}

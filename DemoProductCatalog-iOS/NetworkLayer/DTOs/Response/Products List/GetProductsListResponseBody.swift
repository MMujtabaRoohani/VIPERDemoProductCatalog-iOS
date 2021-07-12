//
//  GetProductsListResponseBody.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import Foundation

struct GetProductsListResponseBody: DTO {
    var currentPage: Int
    var firstPageURL: String?
    var from: Int?
    var lastPage: Int
    var lastPageURL: String?
    var nextPageURL: String?
    var path: String
    var perPage: Int
    var prevPageURL: String?
    var to: Int?
    var total: Int
    var data: [BriefProduct]
    
    // I like to have camelCasing in my entities
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case firstPageURL = "first_page_url"
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case from, path, to, total, data
    }
    
}

//
//  ProductListInteractorMock.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 12/07/2021.
//

import Foundation

/// This mock class returns 10 items on page 1, 2 items on page 2, and an empty array on pages after that and a failure response on negative pages.
class ProductListInteractorMock: ProductListInteractorInterface {
    func getData(for page: Int, completion: @escaping (GetProductsList.Response?, GetProductsList.Failure?, Error?) -> Void) {
        switch page {
        case 1:
            completion(GetProductsList.Response(status: 200, message: "Success", body: GetProductsListResponseBody(currentPage: 1, firstPageURL: nil, from: 1, lastPage: 2, lastPageURL: nil, nextPageURL: nil, path: "", perPage: 10, prevPageURL: nil, to: 10, total: 15, data: [
                BriefProduct(productId: 1, thumbnailURL: "", name: "Product 1", vendorName: "Vendor 1", finalPrice: "10.00"),
                BriefProduct(productId: 2, thumbnailURL: "", name: "Product 2", vendorName: "Vendor 2", finalPrice: "15.00"),
                BriefProduct(productId: 3, thumbnailURL: "", name: "Product 3", vendorName: "Vendor 1", finalPrice: "15.00"),
                BriefProduct(productId: 4, thumbnailURL: "", name: "Product 4", vendorName: "Vendor 2", finalPrice: "15.00"),
                BriefProduct(productId: 5, thumbnailURL: "", name: "Product 5", vendorName: "Vendor 3", finalPrice: "15.00"),
                BriefProduct(productId: 6, thumbnailURL: "", name: "Product 6", vendorName: "Vendor 1", finalPrice: "15.00"),
                BriefProduct(productId: 7, thumbnailURL: "", name: "Product 7", vendorName: "Vendor 3", finalPrice: "35.00"),
                BriefProduct(productId: 8, thumbnailURL: "", name: "Product 8", vendorName: "Vendor 4", finalPrice: "15.00"),
                BriefProduct(productId: 9, thumbnailURL: "", name: "Product 9", vendorName: "Vendor 1", finalPrice: "15.00"),
                BriefProduct(productId: 10, thumbnailURL: "", name: "Product 10", vendorName: "Vendor 2", finalPrice: "25.00")
            ])), nil, nil)
        case 2:
            completion(GetProductsList.Response(status: 200, message: "Success", body: GetProductsListResponseBody(currentPage: 2, firstPageURL: nil, from: 11, lastPage: 2, lastPageURL: nil, nextPageURL: nil, path: "", perPage: 10, prevPageURL: nil, to: 12, total: 12, data: [
                BriefProduct(productId: 11, thumbnailURL: "", name: "Product 1", vendorName: "Vendor 5", finalPrice: "11.00"),
                BriefProduct(productId: 22, thumbnailURL: "", name: "Product 2", vendorName: "Vendor 1", finalPrice: "12.00")
            ])), nil, nil)
        case let x where x > 2:
            completion(GetProductsList.Response(status: 200, message: "Success", body: GetProductsListResponseBody(currentPage: 3, firstPageURL: nil, from: nil, lastPage: 2, lastPageURL: nil, nextPageURL: nil, path: "", perPage: 10, prevPageURL: nil, to: nil, total: 12, data: [])), nil, nil)
        default:
            completion(GetProductsList.Response(status: 200, message: "Success", body: GetProductsListResponseBody(currentPage: 3, firstPageURL: nil, from: nil, lastPage: 2, lastPageURL: nil, nextPageURL: nil, path: "", perPage: 10, prevPageURL: nil, to: nil, total: 12, data: [])), nil, nil)
        }
    }
}

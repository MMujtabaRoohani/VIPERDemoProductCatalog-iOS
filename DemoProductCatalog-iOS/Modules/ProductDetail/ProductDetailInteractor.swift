//
//  ProductDetailInteractor.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

class ProductDetailInteractor: ProductDetailInteractorInterface {
    
    func getData(for product: BriefProduct, completion: @escaping (GetProductDetail.Response?, GetProductDetail.Failure?, Error?) -> Void) {
        let request = GetProductDetail(productId: product.productId)
        Network.shared.request(request) { result in
            switch result {
            case .success(let response):
                completion(response, nil, nil)
            case .failure(let failure):
                completion(nil, failure, nil)
            case .error(let err):
                completion(nil, nil, err)
            }
        }
    }
}

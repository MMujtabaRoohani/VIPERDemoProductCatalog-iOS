//
//  ProductListRouterMock.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 12/07/2021.
//

import UIKit

class ProductListRouterMock: ProductListRouterInterface {
    var navigationController: UINavigationController = UINavigationController()
    
    var openProductDetailsCalledCount: Int = 0
    
    func start() {}
    func openProductDetails(of product: BriefProduct) {
        openProductDetailsCalledCount += 1
    }
}

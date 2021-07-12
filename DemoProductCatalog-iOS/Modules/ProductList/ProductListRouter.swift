//
//  ProductListRouter.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

class ProductListRouter: ProductListRouterInterface {
    
    let navigationController: UINavigationController
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        let view = ProductListViewController.instantiateFromNib()
        let interactor = ProductListInteractor()
        let presenter = ProductListPresenter(view: view, interactor: interactor, router: self)
        
        view.presenter = presenter
        
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func openProductDetails(of product: BriefProduct) {
        let productDetailRouter = ProductDetailRouter(nav: navigationController)
        productDetailRouter.start(with: product)
    }
}

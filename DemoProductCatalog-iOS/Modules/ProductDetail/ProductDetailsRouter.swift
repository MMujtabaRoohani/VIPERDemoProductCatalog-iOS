//
//  ProductDetailsRouter.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

class ProductDetailRouter: ProductDetailRouterInterface {
    
    let navigationController: UINavigationController
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    func start(with product: BriefProduct) {
        let view = ProductDetailViewController.instantiateFromNib()
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter(product: product, view: view, interactor: interactor, router: self)
        
        view.presenter = presenter
        
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func goBack() {
        self.navigationController.popViewController(animated: true)
    }
}

//
//  ProductListTableViewCellPresenter.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 11/07/2021.
//

import Foundation

class ProductListTableViewCellPresenter {
    var product: BriefProduct
    weak var cell: ProductListTableViewCell?
    
    init(product: BriefProduct, cell: ProductListTableViewCell) {
        self.product = product
        self.cell = cell
    }
    
    func populateData() {
        cell?.setProductInfo(product: product)
        if let url = URL(string: product.thumbnailURL) {
            Network.shared.downloadImage(from: url) { [weak self] image, _ in
                self?.cell?.setThumb(image: image)
            }
        }
    }
}

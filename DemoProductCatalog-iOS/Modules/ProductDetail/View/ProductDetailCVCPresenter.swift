//
//  ProductDetailCVCPresenter.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 12/07/2021.
//

import Foundation

class ProductDetailCVCPresenter {
    
    var imageURL: URL
    weak var cell: ProductDetailCollectionViewCell?
    init(imageURL: URL, cell: ProductDetailCollectionViewCell) {
        self.imageURL = imageURL
        self.cell = cell
    }
    
    func fetchImage() {
        Network.shared.downloadImage(from: imageURL) { [weak self] image, _ in
            self?.cell?.set(image: image)
        }
    }
}

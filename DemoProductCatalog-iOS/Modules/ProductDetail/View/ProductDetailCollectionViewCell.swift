//
//  ProductDetailCollectionViewCell.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 12/07/2021.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLoader: UIActivityIndicatorView!
    
    var presenter: ProductDetailCVCPresenter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        imageLoader.startAnimating()
        presenter = nil
        imageView.image = nil
    }
    
    func set(image: UIImage?) {
        imageLoader.stopAnimating()
        imageView.image = image
    }
    
}

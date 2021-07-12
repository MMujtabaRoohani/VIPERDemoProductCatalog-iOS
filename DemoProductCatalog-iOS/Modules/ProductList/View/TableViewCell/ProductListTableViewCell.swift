//
//  ProductListTableViewCell.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var imageLoader: UIActivityIndicatorView!
    
    var presenter: ProductListTableViewCellPresenter?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {  }
    
    override func prepareForReuse() {
        imageLoader.startAnimating()
        mainLabel.text = nil
        secondaryLabel.text = nil
        priceLabel.text = nil
        thumbImage.image = nil
        presenter = nil
    }
    
    func setProductInfo(product: BriefProduct) {
        mainLabel.text = product.name
        secondaryLabel.text = product.vendorName
        priceLabel.text = "$\(product.finalPrice)"
    }
    
    func setThumb(image: UIImage?) {
        imageLoader.stopAnimating()
        thumbImage.image = image
    }
}

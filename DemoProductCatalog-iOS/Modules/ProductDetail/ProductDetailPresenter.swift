//
//  ProductDetailPresenter.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

class ProductDetailPresenter: ProductDetailPresenterInterface {
    private(set) var briefProduct: BriefProduct
    
    weak var view: ProductDetailViewInterface!
    var interactor: ProductDetailInteractorInterface
    var router: ProductDetailRouterInterface
    
    private var productDetail: ProductDetail?
    private var imageURLs: [URL] = []
    private var isFetching: Bool = false
    
    init(product: BriefProduct, view: ProductDetailViewInterface, interactor: ProductDetailInteractorInterface, router: ProductDetailRouterInterface) {
        self.briefProduct = product
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func fetchProductData() {
        guard !isFetching else { return }
        isFetching = true
        interactor.getData(for: briefProduct) { [weak self] response, failure, err in
            guard let self = self else { return }
            self.isFetching = false
            guard failure == nil,
                  err == nil,
                  let response = response else {
                self.view.showError(message: failure?.message ?? (err as? NetworkError)?.description ?? "Something Unexpected Happened")
                return DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.router.goBack()
                }
            }
            self.productDetail = response.body
            self.view.populateData(with: self.productDetail!.name, description: self.getDesc(from: self.productDetail!))
            self.imageURLs = response.body.images.compactMap({ URL(string: $0) })
            self.view.reloadImagesCollection()
        }
    }
    
    func getImageURL(at index: Int) -> URL {
        imageURLs[index]
    }
    
    func getImagesCount() -> Int {
        imageURLs.count
    }
    
    private func getDesc(from product: ProductDetail) -> NSAttributedString {
        let defaultFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        let mutableAttrString = NSMutableAttributedString()
        for (idx, infoItem) in product.info.enumerated() {
            let modifiedFont = NSString(format: "<span style=\"font-family: -apple-system; font-size: \(15)\">%@</span>" as NSString, infoItem.text) as String
            guard let data = modifiedFont.data(using: String.Encoding.utf16, allowLossyConversion: false),
                  let attributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else { continue }
            
            // To support dark mode, remove the hard-coded color attributes
            attributedString.removeAttribute(.foregroundColor, range: NSRange.init(location: 0, length: attributedString.string.count))
            
            mutableAttrString.append(NSAttributedString(string: "\(idx > 0 ? "\n" : "")\(infoItem.name)\n", attributes: [.font: defaultFont]))
            mutableAttrString.append(attributedString)
        }
        
        mutableAttrString.append(NSAttributedString(string: "\nBrand Name\n", attributes: [.font: defaultFont]))
        mutableAttrString.append(NSAttributedString(string: product.brandName, attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .regular)]))
        
        mutableAttrString.append(NSAttributedString(string: "\n\nPrice\n", attributes: [.font: defaultFont]))
        mutableAttrString.append(NSAttributedString(string: "$\(product.finalPrice)", attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .regular)]))
        
        return mutableAttrString
    }
}

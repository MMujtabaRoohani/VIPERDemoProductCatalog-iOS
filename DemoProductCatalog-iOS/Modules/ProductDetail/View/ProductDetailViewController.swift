//
//  ProductDetailViewController.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

class ProductDetailViewController: UIViewController, NibbedVC, ProductDetailViewInterface {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var presenter: ProductDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigation()
        presenter.fetchProductData()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = presenter.briefProduct.name
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib.init(nibName: "ProductDetailCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ProductDetailCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func showError(message: String) {
        self.view.makeToast(message)
    }
    
    func populateData(with title: String, description: NSAttributedString) {
        self.titleLabel.text = title
        self.descLabel.attributedText = description
    }
    
    func reloadImagesCollection() {
        collectionView.reloadData()
    }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailCollectionViewCell", for: indexPath) as! ProductDetailCollectionViewCell
        cell.presenter = ProductDetailCVCPresenter(imageURL: presenter.getImageURL(at: indexPath.item), cell: cell)
        cell.presenter.fetchImage()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getImagesCount()
    }
}

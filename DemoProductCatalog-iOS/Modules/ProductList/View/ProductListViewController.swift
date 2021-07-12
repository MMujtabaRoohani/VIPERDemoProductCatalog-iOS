//
//  ProductListViewController.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

class ProductListViewController: UIViewController, NibbedVC, ProductListViewInterface {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ProductListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigation()
        presenter.getInitialData()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Product Catalog"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "ProductListTableViewCell", bundle: .main), forCellReuseIdentifier: "ProductListTableViewCell")
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func insert(_ count: Int, rowsAt index: Int) {
        tableView.insertRows(at: (index..<index+count).map { IndexPath(row: $0, section: 0) }, with: .top)
    }
    
    func showError(message: String) {
        self.view.makeToast(message)
    }
}

// MARK: - TableView Functions
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        let cellPresenter = ProductListTableViewCellPresenter(product: self.presenter.getProduct(at: indexPath.row), cell: cell)
        cellPresenter.populateData()
        
        cell.presenter = cellPresenter
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getProductsCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.productSelected(product: presenter.getProduct(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.getProductsCount() - 1 {
            presenter.getMoreData()
        }
    }
}

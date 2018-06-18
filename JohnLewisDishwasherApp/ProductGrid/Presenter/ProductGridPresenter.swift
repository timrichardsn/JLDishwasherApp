//
//  ProductGridPresenter.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation

class ProductGridPresenter: ProductGridPresenterProtocol {
    
    weak var view: ProductGridViewProtocol?
    var interactor: ProductGridInteractorProtocol?
    var router: ProductGridRouterProtocol?
    
    var productCount: Int {
        return products.count
    }
    
    private var products = [Product]()
    
    func viewDidLoad() {
        interactor?.fetchProducts()
    }
    
    func viewDidAppear() {
        
    }
    
    func didReceive(products: [Product]) {
        self.products = products
        view?.reloadData()
    }
    
    func product(at indexPath: IndexPath) -> Product {
        return products[indexPath.row]
    }
}

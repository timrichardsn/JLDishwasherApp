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
    
    func viewDidLoad() {
        interactor?.fetchProducts()
    }
    
    func viewWillAppear() {
        OrientationLocker.lockAndRotateToLandscape()
    }
    
    func didReceive(products: [Product]) {
        view?.show(products: products)
    }
    
    func didReceive(product: Product) {
        
    }
    
    func cellSizeFrom(collectionViewSize: Size) -> Size {
        
        return Size(width: collectionViewSize.width / 4, height: collectionViewSize.height / 2)
    }
    
    func configure(productGridCell: ProductGridCellProtocol, with product: Product) {
        productGridCell.configure(with: product)
    }
    
    func showProductDetail(forProduct product: Product) {
        interactor?.fetchData(for: product)
    }
}

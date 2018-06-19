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
    
    func viewDidAppear() {
        OrientationLocker.lockAndRotateToLandscape()
    }
    
    func didReceive(products: [Product]) {
        view?.show(products: products)
    }
    
    func cellSizeFrom(collectionViewSize: Size) -> Size {
        
        return Size(width: collectionViewSize.width / 4, height: collectionViewSize.height / 2)
    }
    
    func configure(productGridCell: ProductGridCellProtocol, at indexPath: IndexPath) {
        productGridCell.configure(with: product(at: indexPath))
    }
}

//
//  ProductGridInteractor.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation

class ProductGridInteractor: ProductGridInteractorProtocol {
   
    weak var presenter: ProductGridPresenterProtocol?
    var remoteDataManager: ProductGridRemoteDataProtocol?
    
    func fetchProducts() {
        
        let parameters: [RequestParameterKey: Any] = [
            .product : "dishwasher",
            .pageSize: "20"
        ]
        
        let requestData = RequestData(endPoint: .products(action: .search), parameters: parameters)
        remoteDataManager?.fetchProducts(with: requestData)
    }
    
    func fetchData(for product: Product) {
        
        let requestData = RequestData(endPoint: .products(action: .data(id: product.productId)), parameters: [:])
        remoteDataManager?.fetchProductData(with: requestData)
    }
}

extension ProductGridInteractor: ProductGridRemoteDataOutputProtocol {
    
    func onProductReceived(product: Product) {
        presenter?.didReceive(product: product)
    }
    
    func onProductsReceived(products: [Product]) {
        presenter?.didReceive(products: products)
    }
    
    func onError() {
        
    }
}

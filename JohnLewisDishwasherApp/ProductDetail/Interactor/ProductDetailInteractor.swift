//
//  ProductDetailInteractor.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation

class ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    weak var presenter: ProductDetailViewPresenterProtocol?
    var remoteDataManager: ProductDetailRemoteDataProtocol?
    
    func fetchProductData(for product: Product) {
        
        let requestData = RequestData(endPoint: .products(action: .search), parameters: [:])
        
        remoteDataManager?.performRequest(with: requestData)
    }
}

extension ProductDetailInteractor: ProductDetailRemoteDataOutputProtocol {
    
    func onProductDataReceived(product: Product) {
        
    }
    
    func onError() {
        
    }
}

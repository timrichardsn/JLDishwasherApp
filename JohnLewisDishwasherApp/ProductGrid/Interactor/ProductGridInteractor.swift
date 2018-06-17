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
        
        
        let requestData = RequestData(endPoint: .products(action: .search), parameters: [:])
        remoteDataManager?.performRequest(with: requestData)
    }
}

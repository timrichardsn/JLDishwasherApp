//
//  ProductGridRemoteDataManager.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation

class ProductGridRemoteDataManager: ProductGridRemoteDataProtocol {
    
    weak var remoteDataOutputHandler: ProductGridRemoteDataOutputProtocol?
    
    func performRequest(with requestData: RequestData) {
        
        performRequest(with: requestData, networkDataRequest: nil)
    }
    
    func performRequest(with requestData: RequestData, networkDataRequest: NetworkDataRequest? = nil) {
        
        networkDataRequest?.checkResponse(callback: { [remoteDataOutputHandler] json, error in
            
            if let _ = json {
                remoteDataOutputHandler?.onProductsReceived()
            } else {
                remoteDataOutputHandler?.onError()
            }
        })
    }
}
    }
}

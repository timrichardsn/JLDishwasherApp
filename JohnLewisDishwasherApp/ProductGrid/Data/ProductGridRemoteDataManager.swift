//
//  ProductGridRemoteDataManager.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation
import Alamofire

class ProductGridRemoteDataManager: ProductGridRemoteDataProtocol {
    
    weak var remoteDataOutputHandler: ProductGridRemoteDataOutputProtocol?
    
    func performRequest(with requestData: RequestData) {
        
        performRequest(with: requestData, networkDataRequest: nil)
    }
    
    func performRequest(with requestData: RequestData, networkDataRequest: NetworkDataRequest? = nil) {
        
        var networkDataRequest = networkDataRequest
        networkDataRequest = networkDataRequest ?? Alamofire.request(requestData.endPoint.urlString,
                                                                     parameters: requestData.parametersForRequest(includeKey: true))
        
        networkDataRequest?.checkResponse(callback: { [remoteDataOutputHandler] json, error in
            
            if let json = json {
                print("Success: \(json)")
                remoteDataOutputHandler?.onProductsReceived()
            } else {
                remoteDataOutputHandler?.onError()
            }
        })
    }
}

extension DataRequest: NetworkDataRequest {
    
    func checkResponse(callback: @escaping (Any?, Error?) -> Void) {
        
        validate().responseJSON { response in
            
            switch response.result {
            case .success(let json): callback(json, nil)
            case .failure(let error): callback(nil, error)
            }
        }
    }
}

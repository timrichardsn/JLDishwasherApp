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
            
            // Need to add better error feedback here, via a custom enum error type
            if let json = json as? [String: Any], let products = json["products"] as? [[String: Any]] {
                
                let products = products.map {
                    
                    // Would not force unwrap here in production...
                    Product(productId: $0["productId"] as! String,
                            title: $0["title"] as! String,
                            imageUrl: $0["image"] as! String,
                            priceData: $0["price"] as! [String: String])
                }
                
                remoteDataOutputHandler?.onProductsReceived(products: products)
                
                
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

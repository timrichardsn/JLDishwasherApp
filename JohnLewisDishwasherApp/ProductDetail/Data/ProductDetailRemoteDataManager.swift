//
//  ProductDetailRemoteDataManager.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation
import Alamofire

private typealias ReturnData = [String: Any]

class ProductDetailRemoteDataManager: ProductDetailRemoteDataProtocol {
    
    weak var remoteDataOutputHandler: ProductDetailRemoteDataOutputProtocol?
    
    func performRequest(with requestData: RequestData) {
        
        // FIXME: Better error handling required for production level apps
        // This approach could also be optimised by making the request silently in the background before presenting the data
        Alamofire.request(requestData.endPoint.urlString, parameters: requestData.parametersForRequest(includeKey: true))
            .validate()
            .responseJSON { [remoteDataOutputHandler] response in
            
                switch response.result {
                case .success(let json):
                    
                    if let productData = json as? ReturnData {
                        
                        guard
                        let productId = productData["productId"] as? String,
                        let title = productData["title"] as? String,
                        let priceData = productData["price"] as? [String: String]
                        else {
                            remoteDataOutputHandler?.onError()
                            return
                        }
                        
                        var product = Product(productId: productId, title: title, priceData: priceData, imageUrl: nil)
                        product.displaySpecialOffer = productData["displaySpecialOffer"] as? String
                        product.code = productData["code"] as? String
                        
                        if let details = productData["details"] as? ReturnData {
                            product.productInformation = details["productInformation"] as? String
                            
                            if let features = details["features"] as? [ReturnData], let firstFeature = features.first {
                                product.attributes = firstFeature["attributes"] as? [ReturnData]
                            }
                        }
                        
                        if let additionalServices = productData["additionalServices"] as? ReturnData {
                            product.guaranteeInformation = additionalServices["includedServices"] as? [String]
                        }
                        
                        if let media = productData["media"] as? ReturnData, let images = media["images"] as? ReturnData {
                            product.urls = images["urls"] as? [String]
                        }
                        
                        remoteDataOutputHandler?.onProductDataReceived(product: product)
                    } else {
                        remoteDataOutputHandler?.onError()
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                    // FIXME: Pass the error out...
                    remoteDataOutputHandler?.onError()
                }
            
            }
    }
}

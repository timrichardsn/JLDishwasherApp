//
//  ProductGridRemoteDataManager.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation
import Alamofire

private typealias ReturnData = [String: Any]

class ProductGridRemoteDataManager: ProductGridRemoteDataProtocol {
    
    weak var remoteDataOutputHandler: ProductGridRemoteDataOutputProtocol?
    
    func fetchProducts(with requestData: RequestData) {
        
        fetchProducts(with: requestData, networkDataRequest: nil)
    }
    
    func fetchProducts(with requestData: RequestData, networkDataRequest: NetworkDataRequest? = nil) {
        
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
                            priceData: $0["price"] as! [String: String],
                            imageUrl: $0["image"] as? String)
                }
                
                remoteDataOutputHandler?.onProductsReceived(products: products)
                
                
            } else {
                remoteDataOutputHandler?.onError()
            }
        })
    }
    
    func fetchProductData(with requestData: RequestData) {
        fetchProductData(with: requestData, networkDataRequest: nil)
    }
    
    func fetchProductData(with requestData: RequestData, networkDataRequest: NetworkDataRequest?) {
        var networkDataRequest = networkDataRequest
        networkDataRequest = networkDataRequest ?? Alamofire.request(requestData.endPoint.urlString,
                                                                     parameters: requestData.parametersForRequest(includeKey: true))
        
        networkDataRequest?.checkResponse(callback: { [remoteDataOutputHandler] json, error in
            
            // Need to add better error feedback here, via a custom enum error type
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
                
                remoteDataOutputHandler?.onProductReceived(product: product)
                
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

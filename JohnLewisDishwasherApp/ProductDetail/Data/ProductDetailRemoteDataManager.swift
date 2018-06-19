//
//  ProductDetailRemoteDataManager.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation
import Alamofire

class ProductDetailRemoteDataManager: ProductDetailRemoteDataProtocol {
    
    weak var remoteDataOutputHandler: ProductDetailRemoteDataOutputProtocol?
    
    func performRequest(with requestData: RequestData) {
        
        Alamofire.request(requestData.endPoint.urlString, parameters: requestData.parametersForRequest(includeKey: true))
            .validate()
            .responseJSON { [remoteDataOutputHandler] response in
            
                switch response.result {
                case .success(let json):
                    print("Success: \(json)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            
            }
    }
}

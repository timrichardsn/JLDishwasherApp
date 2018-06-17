//
//  RequestData.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation

struct API {
    static let rootUrlString = "https://api.johnlewis.com/v1"
    static let key = "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
}

enum APIAction {
    case search
    
    var endpointString: String {
        switch self {
        case .search:
            return "search"
        }
    }
}

enum Endpoint {
    case products(action: APIAction)
    
    var endpointString: String {
        switch self {
        case .products(let action):
            return "products/\(action.endpointString)"
        }
    }
    
    var urlString: String {
        return "\(API.rootUrlString)/\(endpointString)"
    }
}

enum RequestParameterKey {
    case product, key, pageSize
    
    var stringValue: String {
        switch self {
        case .product: return "q"
        case .key: return "key"
        case .pageSize: return "pageSize"
        }
    }
}

struct RequestData {
    let endPoint: Endpoint
    let parameters: [RequestParameterKey: Any]
    
    func parametersForRequest(includeKey: Bool) -> [String: Any] {
        
        var parametersForRequest = Dictionary(uniqueKeysWithValues: parameters.map { ($0.key.stringValue, $0.value) })
        
        if includeKey {
            parametersForRequest[RequestParameterKey.key.stringValue] = API.key
        }
        
        return parametersForRequest
    }
}

protocol NetworkDataRequest {
    func checkResponse(callback: @escaping (Any?, Error?) -> Void)
}

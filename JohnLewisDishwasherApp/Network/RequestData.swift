//
//  RequestData.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import Foundation

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
        return "https://api.johnlewis.com/v1/\(endpointString)"
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

struct API {
    static let key = "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
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

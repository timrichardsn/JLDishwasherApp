//
//  EndpointTests.swift
//  JohnLewisDishwasherAppTests
//
//  Created by Tim Richardson on 19/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import XCTest
@testable import JohnLewisDishwasherApp

class EndpointTests: XCTestCase {
    
    func testRequestData() {
        
        let parameters: [RequestParameterKey: Any] = [
            .product : "dishwasher",
            .pageSize: "20"
        ]
        
        let requestData = RequestData(endPoint: .products(action: .search), parameters: parameters)
        
        XCTAssertEqual(requestData.endPoint.endpointString, "products/search")
        XCTAssertEqual(requestData.endPoint.urlString, "\(API.rootUrlString)/products/search")
        XCTAssertNotNil(requestData.parameters)
        
        let parametersForRequest = requestData.parametersForRequest(includeKey: true)
        
        XCTAssertEqual(parametersForRequest.count, 3)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.product.stringValue] as? String, parameters[.product] as? String)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.pageSize.stringValue] as? String, parameters[.pageSize] as? String)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.key.stringValue] as? String, API.key)
    }
    
    func testRequestParameters() {
        
        XCTAssertEqual(RequestParameterKey.product.stringValue, "q")
        XCTAssertEqual(RequestParameterKey.key.stringValue, "key")
        XCTAssertEqual(RequestParameterKey.pageSize.stringValue, "pageSize")
    }
}

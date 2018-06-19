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
        
        var requestData = RequestData(endPoint: .products(action: .search), parameters: parameters)
        
        XCTAssertEqual(requestData.endPoint.endpointString, "products/search")
        XCTAssertEqual(requestData.endPoint.urlString, "\(API.rootUrlString)/products/search")
        XCTAssertNotNil(requestData.parameters)
        
        var parametersForRequest = requestData.parametersForRequest(includeKey: true)
        
        XCTAssertEqual(parametersForRequest.count, 3)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.product.stringValue] as? String, parameters[.product] as? String)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.pageSize.stringValue] as? String, parameters[.pageSize] as? String)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.key.stringValue] as? String, API.key)
        
        requestData = RequestData(endPoint: .products(action: .data(id: "123")), parameters: [:])
        
        XCTAssertEqual(requestData.endPoint.endpointString, "products/123")
        XCTAssertEqual(requestData.endPoint.urlString, "\(API.rootUrlString)/products/123")
        XCTAssertNotNil(requestData.parameters)
        
        parametersForRequest = requestData.parametersForRequest(includeKey: true)
        
        XCTAssertEqual(parametersForRequest.count, 1)
        XCTAssertEqual(parametersForRequest[RequestParameterKey.key.stringValue] as? String, API.key)
    }
    
    func testRequestParameters() {
        
        XCTAssertEqual(RequestParameterKey.product.stringValue, "q")
        XCTAssertEqual(RequestParameterKey.key.stringValue, "key")
        XCTAssertEqual(RequestParameterKey.pageSize.stringValue, "pageSize")
    }
}

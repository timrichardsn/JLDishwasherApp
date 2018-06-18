//
//  ProductGridProtocols.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

protocol ProductGridRouterProtocol: class {
    static func createProductGridModule() -> UIViewController
}

protocol ProductGridViewProtocol: class {
    var presenter: ProductGridPresenterProtocol? { get set }
    
    func reloadData()
}

protocol ProductGridPresenterProtocol: class {
    
    var view: ProductGridViewProtocol? { get set }
    var interactor: ProductGridInteractorProtocol? { get set }
    var router: ProductGridRouterProtocol? { get set }
    
    func viewDidLoad()
    func didReceive(products: [Product])
}

protocol ProductGridInteractorProtocol: class {
    var presenter: ProductGridPresenterProtocol? { get set }
    var remoteDataManager: ProductGridRemoteDataProtocol? { get set }
    
    func fetchProducts()
}

protocol ProductGridRemoteDataProtocol: class {
    
    var remoteDataOutputHandler: ProductGridRemoteDataOutputProtocol? { get set }
    
    func performRequest(with requestData: RequestData)
    func performRequest(with requestData: RequestData, networkDataRequest: NetworkDataRequest?)
}

protocol ProductGridRemoteDataOutputProtocol: class {
    
    func onProductsReceived(products: [Product])
    func onError()
}

//
//  ProductGridProtocols.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 17/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

typealias Size = (width: Float, height: Float)

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
    var productCount: Int { get }
    
    func viewDidLoad()
    func viewDidAppear()
    func didReceive(products: [Product])
    func product(at indexPath: IndexPath) -> Product
    func cellSizeFrom(collectionViewSize: Size, at indexPath: IndexPath) -> Size
    func configure(productGridCell: ProductGridCellProtocol, at indexPath: IndexPath)
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

protocol ProductGridCellProtocol: class {
    func configure(with product: Product)
}

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
}

protocol ProductGridPresenterProtocol: class {
    
    var view: ProductGridViewProtocol? { get set }
    var interactor: ProductGridInteractorProtocol? { get set }
    var router: ProductGridRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol ProductGridInteractorProtocol: class {
    var presenter: ProductGridPresenterProtocol? { get set }
}

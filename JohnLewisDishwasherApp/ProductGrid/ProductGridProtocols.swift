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
    
}

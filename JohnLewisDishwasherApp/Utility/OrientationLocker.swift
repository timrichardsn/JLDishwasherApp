//
//  OrientationLocker.swift
//  JohnLewisDishwasherApp
//
//  Created by Tim Richardson on 18/06/2018.
//  Copyright © 2018 Tim Richardson. All rights reserved.
//

import UIKit

struct OrientationLocker {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientation = orientation
        }
    }
}

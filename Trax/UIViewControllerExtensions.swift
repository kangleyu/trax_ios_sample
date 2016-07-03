//
//  UIViewControllerExtensions.swift
//  Trax
//
//  Created by Tom Yu on 7/3/16.
//  Copyright © 2016 kangleyu. All rights reserved.
//

import UIKit

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
}

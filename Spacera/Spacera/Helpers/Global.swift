//
//  Global.swift
//  Spacera
//
//  Created by Artem Bilyi on 10.12.2022.
//

import Foundation

struct GlobalLinks {
    static let spaceRockets = "https://api.spacexdata.com/v4/rockets"
    static let launches = "https://api.spacexdata.com/v4/launches"
}

import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

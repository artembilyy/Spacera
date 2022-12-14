//
//  Fonts.swift
//  Spacera
//
//  Created by Artem Bilyi on 18.12.2022.
//

import UIKit
enum LabGrotesque: String {
    case bold    = "LabGrotesque-Bold"
    case medium  = "LabGrotesque-Medium"
    case regular = "LabGrotesque-Regular"
    case thin    = "LabGrotesque-Thin"
}

extension UIFont {
    static func setFont(name: String, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: name, size: size) else {
            fatalError("Failed to load the LabGrotesque font.")
        }
        let font = UIFontMetrics.default.scaledFont(for: customFont)
        return font
    }
}

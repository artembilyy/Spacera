//
//  Colors.swift
//  Spacera
//
//  Created by Artem Bilyi on 26.12.2022.
//

import UIKit

enum Fonts {
    case customDeepGray
    case customWhire
    case customLightGray
    case customMidGray
    case customGray
    case customBlack
    case customLightBlack
    var color: UIColor {
        switch self {
        case .customDeepGray:
            return UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        case .customWhire:
            return UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        case .customLightGray:
            return UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1)
        case .customMidGray:
            return UIColor(red: 142/255, green: 142/255, blue: 143/255, alpha: 1)
        case .customBlack:
            return UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
        case . customLightBlack:
            return UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        case .customGray:
            return UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
        }
    }
}

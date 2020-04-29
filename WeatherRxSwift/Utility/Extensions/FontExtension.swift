//
//  FontExtension.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 11/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

extension UIFont {
    static func boldFont(size: CGFloat) -> UIFont {
        return UIFont(font: FontFamily.ApexRounded.heavy, size: size)
    }

    static func regularFont(size: CGFloat) -> UIFont {
        return UIFont(font: FontFamily.ApexRounded.medium, size: size)
    }

    static func lightFont(size: CGFloat) -> UIFont {
        return UIFont(font: FontFamily.ApexRounded.book, size: size)
    }
}

extension UIFont {
    static var navigationBarTitle: UIFont {
        return .lightFont(size: 24)
    }

    static var navigationBarButtonItem: UIFont {
        return .lightFont(size: 20)
    }

    static var heading1: UIFont {
        return .regularFont(size: 25)
    }

    static var heading2: UIFont {
        return .boldFont(size: 25)
    }

    static var body1: UIFont { // city list view
        return .regularFont(size: 20)
    }

    static var body2: UIFont { // city search
        return .lightFont(size: 20)
    }

    static var body3: UIFont { // city search
        return .regularFont(size: 18)
    }

    static var detailTitle: UIFont {
        return .lightFont(size: 16)
    }

    static var detailBody: UIFont {
        return .regularFont(size: 24)
    }
}

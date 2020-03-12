//
//  ColourConstant.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 3/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

extension UIColor {
    static var viewBackgroundColor: UIColor {
        return Asset.ColorsAssets.viewBackgroundColor.color
    }

    static var titleColor: UIColor {
        return Asset.ColorsAssets.titleColor.color
    }

    static var descriptionColor: UIColor {
        return Asset.ColorsAssets.descriptionColor.color
    }

    static var addCityViewBackgroundColor: UIColor {
        return UIColor(rgb: 0xEAE8EA)
    }
    static var barTintColor: UIColor {
        return UIColor(rgb: 0x5c9ac1)
    }

    static var titleTintColor: UIColor {
        return UIColor.white
    }
}
extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

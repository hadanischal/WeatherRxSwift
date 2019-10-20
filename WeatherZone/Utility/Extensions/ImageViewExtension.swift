//
//  ImageViewExtension.swift
//  WeatherZone
//
//  Created by Nischal Hada on 19/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(url: URL) {
        self.kf.setImage(with: url)
    }
}

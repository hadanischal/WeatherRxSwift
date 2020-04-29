//
//  ImageViewExtension.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 19/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    public func setImage(url: URL) {
        self.kf.setImage(with: url)
    }
}

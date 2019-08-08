//
//  AlertAction.swift
//  WeatherZone
//
//  Created by Nischal Hada on 7/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

public struct AlertAction {

    public let title: String
    public let type: Int
    public let style: UIAlertAction.Style

    public init(title: String,
                type: Int = 0,
                style: UIAlertAction.Style = .default) {
        self.title = title
        self.type = type
        self.style = style
    }
}

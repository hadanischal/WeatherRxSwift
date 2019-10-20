//
//  NibLoadableView.swift
//  WeatherZone
//
//  Created by Nischal Hada on 12/10/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }

}

extension UITableViewCell: NibLoadableView { }

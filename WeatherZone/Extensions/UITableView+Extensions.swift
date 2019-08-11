//
//  UITableView+Extensions.swift
//  WeatherZone
//
//  Created by Nischal Hada on 10/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

extension UITableView {
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }
}

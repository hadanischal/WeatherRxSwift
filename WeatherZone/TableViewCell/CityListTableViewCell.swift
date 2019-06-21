//
//  CityListTableViewCell.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

class CityListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityTemperature: UILabel!
    
    var model : WeatherResult? {
        didSet {
            guard let data = model else {
                return
            }
            labelCityName.text = data.name
            labelCityTemperature.text = "\(data.main?.temp ?? 0) °C"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

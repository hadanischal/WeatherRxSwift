//
//  CityListTableViewCell.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import Kingfisher

class CityListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityTemperature: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!

    var model: WeatherResult? {
        didSet {
            guard let data = model else {
                return
            }
            labelCityName.text = data.name
            if let main = data.main {
                labelCityTemperature.text = "\(main.temp) °C"
            }
            if
                let weather = data.weather,
                weather.count > 0 {
                let imageIcon = weather[0].icon
                if let url = URL.iconURL(imageIcon) {
                self.weatherImageView.setImage(url: url)
                }
            }

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .viewBackgroundColor
        self.labelCityName.font = .body1
        self.labelCityTemperature.font = .body1
    }
}

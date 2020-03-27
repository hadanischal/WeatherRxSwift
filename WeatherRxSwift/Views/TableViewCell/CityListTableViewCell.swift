//
//  CityListTableViewCell.swift
//  WeatherRxSwift
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

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .viewBackgroundColor
        self.labelCityName.font = .body1
        self.labelCityTemperature.font = .body1
        self.labelCityName?.textColor = .titleColor
        self.labelCityTemperature?.textColor = .descriptionColor
    }

    func configure(_ data: WeatherDataModel?) {
        guard let data = data else { return }
        labelCityName.text = data.cityName
        labelCityTemperature.text = data.temperature
        weatherImageView.setImage(url: data.iconURL)
    }
}

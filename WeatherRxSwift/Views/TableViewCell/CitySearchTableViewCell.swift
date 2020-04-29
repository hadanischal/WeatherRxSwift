//
//  CitySearchTableViewCell.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 15/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

class CitySearchTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        //        contentView.backgroundColor = .viewBackgroundColor
        self.textLabel?.font = .body2
        self.detailTextLabel?.font = .body3
        self.textLabel?.textColor = .titleColor
        self.detailTextLabel?.textColor = .descriptionColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ data: CityListModel) {
        textLabel?.text = data.name?.capitalized
        detailTextLabel?.text = data.country?.capitalized
    }
}

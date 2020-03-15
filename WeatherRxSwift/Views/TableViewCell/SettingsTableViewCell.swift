//
//  SettingsTableViewCell.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 12/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
//        contentView.backgroundColor = .viewBackgroundColor
        self.textLabel?.font = .body2//.body1
        self.detailTextLabel?.font = .detailBody
        self.textLabel?.textColor = .titleColor
        self.detailTextLabel?.textColor = .descriptionColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ unit: SettingsUnit) {
        textLabel?.text = unit.displayName.capitalized
        detailTextLabel?.text = unit.unitSymbol
    }
}

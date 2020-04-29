//
//  WeatherDetailTableViewCell.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 11/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .viewBackgroundColor
        self.labelTitle?.font = .body1
        self.labelDescription?.font = .detailBody
        self.labelTitle?.textColor = .titleColor
        self.labelDescription?.textColor = .descriptionColor
    }

    func configure(_ data: DetailModel) {
        labelTitle.text = data.title
        labelDescription.text = data.description
    }
}

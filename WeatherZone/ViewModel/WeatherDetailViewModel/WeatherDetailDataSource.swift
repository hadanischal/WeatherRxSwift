//
//  WeatherDetailDataSource.swift
//  WeatherZone
//
//  Created by Nischal Hada on 11/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift

protocol WeatherDetailDataSource {
    var detailList: Observable<[DetailModel]> { get }
    func getDetailResult()
}

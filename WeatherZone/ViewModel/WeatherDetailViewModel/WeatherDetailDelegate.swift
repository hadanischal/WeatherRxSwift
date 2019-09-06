//
//  WeatherDetailDelegate.swift
//  WeatherZone
//
//  Created by Nischal Hada on 11/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift

//swiftlint:disable class_delegate_protocol
protocol WeatherDetailDelegate {
    var detailList: Observable<[DetailModel]> { get }
    func getDetailResult()
}

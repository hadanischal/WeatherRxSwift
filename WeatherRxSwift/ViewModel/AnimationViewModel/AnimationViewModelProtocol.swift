//
//  AnimationViewModelProtocol.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 7/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import Lottie

protocol AnimationViewModelProtocol {
    var animation: Observable<Animation?> { get }
}

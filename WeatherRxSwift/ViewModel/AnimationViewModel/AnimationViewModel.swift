//
//  AnimationViewModel.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 7/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import Lottie
import RxCocoa
import RxSwift

protocol AnimationDataSource {
    var animation: Observable<Animation?> { get }
}

final class AnimationViewModel: AnimationDataSource {
    var animation: Observable<Animation?>

    init() {
        let programmingAnimation = Animation.named("weather-app-animation", subdirectory: "")
        animation = Observable.just(programmingAnimation)
    }
}

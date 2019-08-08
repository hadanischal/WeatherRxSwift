//
//  AnimationViewModel.swift
//  WeatherZone
//
//  Created by Nischal Hada on 7/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Lottie

class AnimationViewModel: AnimationViewModelProtocol {
    var animation: Driver<Animation?>
    
    
    init() {
        let programmingAnimation = Animation.named("programmingAnimation", subdirectory: "")
        animation = Driver.just(programmingAnimation)
    }
}

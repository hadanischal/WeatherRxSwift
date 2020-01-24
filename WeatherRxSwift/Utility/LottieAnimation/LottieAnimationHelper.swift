//
//  LottieAnimationHelper.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 8/9/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
import Lottie
import RxSwift

class LottieAnimationHelper {
    let animationView = AnimationView()
    /// *** Keypath Setting
    private let animationKeypathSwitchOutline = AnimationKeypath(keypath: "Switch Outline Outlines.**.Fill 1.Color")
    private let animationKeypathCheckmarkOutline = AnimationKeypath(keypath: "Checkmark Outlines 2.**.Stroke 1.Color")
    private let redValueProvider = ColorValueProvider(Color(r: 1, g: 0.2, b: 0.3, a: 1))

    func playAnimation() -> Completable {

        return Completable.create { completable in
            self.animationView.play(fromProgress: 0,
                               toProgress: 1,
                               loopMode: LottieLoopMode.playOnce,
                               completion: { (finished) in
                                if finished {
                                    print("Animation Complete")
                                    completable(.completed)
                                } else {
                                    completable(.error(RxError.noElements))
                                    print("Animation cancelled")
                                }
            })
            return Disposables.create()
        }
    }

    func lottieAnimation(withView view: UIView, withAnimation animation: Animation) {

        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)

        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)

        /// *** Keypath Setting
        animationView.setValueProvider(redValueProvider,
                                       keypath: animationKeypathSwitchOutline)
        animationView.setValueProvider(redValueProvider,
                                       keypath: animationKeypathCheckmarkOutline)
    }

}

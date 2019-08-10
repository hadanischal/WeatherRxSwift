//
//  AnimationViewController.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

class AnimationViewController: UIViewController {
    var viewModel: AnimationViewModelProtocol = AnimationViewModel()

    @IBOutlet weak var animationView1: AnimationView!
    let animationView = AnimationView()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView.play(fromProgress: 0,
                           toProgress: 1,
                           loopMode: LottieLoopMode.playOnce,
                           completion: { (finished) in
                            if finished {
                                print("Animation Complete")
                                self.displayRootView()
                            } else {
                                print("Animation cancelled")
                            }
        })

    }

    private func setupViewModel() {
        viewModel
            .animation
            .asDriver(onErrorJustReturn: nil)
            //            .filter { $0 == nil}
            .drive(onNext: { [weak self] lottieAnimation in
                if let animation = lottieAnimation {
                    self?.lottieAnimation(withAnimation: animation)
                } else {
                    print("Lottie file not found")
                    self?.displayRootView()
                }

            }).disposed(by: disposeBag)

    }

    private func lottieAnimation(withAnimation animation: Animation) {

        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView1.addSubview(animationView)

        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        animationView.bottomAnchor.constraint(equalTo: animationView1.bottomAnchor, constant: -12).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)

        /// *** Keypath Setting

        let redValueProvider = ColorValueProvider(Color(r: 1, g: 0.2, b: 0.3, a: 1))
        animationView.setValueProvider(redValueProvider, keypath: AnimationKeypath(keypath: "Switch Outline Outlines.**.Fill 1.Color"))
        animationView.setValueProvider(redValueProvider, keypath: AnimationKeypath(keypath: "Checkmark Outlines 2.**.Stroke 1.Color"))
    }

    private func displayRootView() {
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            // DispatchQueue.main.async { [weak self] in
            self?.performSegue(withIdentifier: "segueWeatherListView", sender: nil)
        }
    }

}

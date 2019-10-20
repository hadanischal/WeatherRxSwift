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
import CocoaLumberjack

class AnimationViewController: UIViewController {
    var viewModel: AnimationViewModelProtocol = AnimationViewModel()
    let lottieAnimationHelper = LottieAnimationHelper()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
                    DDLogInfo("Lottie file not found")
                    self?.displayRootView()
                }

            }).disposed(by: disposeBag)

    }

    private func lottieAnimation(withAnimation animation: Animation) {
        lottieAnimationHelper.lottieAnimation(withView: self.view, withAnimation: animation)

        lottieAnimationHelper.playAnimation()
            .subscribe(onCompleted: { [weak self] in
                self?.displayRootView()
                }, onError: { error in
                    DDLogError("onError: \(error)")
            }).disposed(by: disposeBag)

    }

    private func displayRootView() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherTableViewController") as? WeatherTableViewController else {
                    assertionFailure("viewController not found")
                    return
                }
                let navigationController = NavigationController(rootViewController: viewController)
                window.rootViewController = navigationController
            }
        }
    }

}

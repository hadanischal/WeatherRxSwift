//
//  AnimationViewController.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 6/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

final class AnimationViewController: UIViewController {
    var viewModel: AnimationDataSource = AnimationViewModel()
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
                    print("Lottie file not found")
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
                    print("onError: \(error)")
            }).disposed(by: disposeBag)

    }

    private func displayRootView() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
                let viewController = StoryboardScene.Main.weatherTableViewController.instantiate()
                let navigationController = NavigationController(rootViewController: viewController)
                window.rootViewController = navigationController
            }
        }
    }

}

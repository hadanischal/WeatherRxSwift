//
//  AnimationViewController.swift
//  WeatherZone
//
//  Created by Nischal Hada on 6/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {

    @IBOutlet weak var animationView1: AnimationView!
    let animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lottieAnimation()
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

    private func lottieAnimation() {
        
        guard
            let animation = Animation.named("programmingAnimation", subdirectory: "")
            else {
            print("Lottie file not found")
            self.displayRootView()
            return
        }
        
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

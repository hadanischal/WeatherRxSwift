//
//  AnimationViewModelTests.swift
//  WeatherRxSwiftTests
//
//  Created by Nischal Hada on 9/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Lottie
import Nimble
import Quick
import RxTest
import XCTest

@testable import WeatherRxSwift

class AnimationViewModelTests: QuickSpec {
    override func spec() {
        var testViewModel: AnimationViewModel!
        var testScheduler: TestScheduler!

        describe("AnimationViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                testViewModel = AnimationViewModel()
            }

            describe("animation value is set properly") {
                it("sets the animation value", closure: {
                    let testObservable = testViewModel.animation
                    let res = testScheduler.start { testObservable }
                    expect(res.events.count).to(equal(2))
                })
            }
        }
    }
}

private let mockAnimation = Animation.named("programmingAnimation", subdirectory: "")

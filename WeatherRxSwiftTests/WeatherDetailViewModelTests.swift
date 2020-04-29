//
//  WeatherDetailViewModelTests.swift
//  WeatherRxSwiftTests
//
//  Created by Nischal Hada on 17/8/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxSwift
import RxTest
import XCTest

@testable import WeatherRxSwift

final class WeatherDetailViewModelTests: QuickSpec {
    override func spec() {
        var testViewModel: WeatherDetailViewModel!
        var mockDetailListHandler: MockDetailListHandlerProtocol!
        var testScheduler: TestScheduler!
        let mockDetailList = MocksInfo.mockDetailModelList()
        let mockWeatherResult = MocksInfo.weatherResult

        describe("WeatherDetailViewModel") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockDetailListHandler = MockDetailListHandlerProtocol()
                stub(mockDetailListHandler) { stub in
                    when(stub.getDetailInfo()).thenReturn(Observable.just(mockDetailList))
                }
                testViewModel = WeatherDetailViewModel(withDetailListHandler: mockDetailListHandler,
                                                       withWeatherResultModel: mockWeatherResult,
                                                       withSchedulerType: MainScheduler.instance)
            }

            describe("Get detail information List from json file") {
                context("when get request succeed") {
                    beforeEach {
                        stub(mockDetailListHandler) { stub in
                            when(stub.getDetailInfo()).thenReturn(Observable.just(mockDetailList))
                        }
                        testViewModel.getDetailResult()
                    }
                    it("calls to the CityListHandler to get city info") {
                        verify(mockDetailListHandler).getDetailInfo()
                    }
                    it("emits weather changed for detail to the UI") {
                        testScheduler.scheduleAt(300) {
                            testViewModel.getDetailResult()
                        }
                        let res = testScheduler.start { testViewModel.detailList }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.next(300, mockDetailList)]
                        expect(res.events).to(equal(correctResult))
                    }
                }

                context("when get detail information List fails") {
                    beforeEach {
                        stub(mockDetailListHandler) { stub in
                            when(stub.getDetailInfo()).thenReturn(Observable.error(RxError.noElements))
                        }
                        testViewModel.getDetailResult()
                    }
                    it("calls to the CityListHandler to get city info") {
                        verify(mockDetailListHandler).getDetailInfo()
                    }
                    it("emits weather changed for detail to the UI") {
                        testScheduler.scheduleAt(300) {
                            testViewModel.getDetailResult()
                        }
                        let res = testScheduler.start { testViewModel.detailList }
                        expect(res.events.count).to(equal(0))
                        let correctResult: [Recorded<Event<[DetailModel]>>] = []
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }
        }
    }
}

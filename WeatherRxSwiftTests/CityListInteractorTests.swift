//
//  CityListInteractorTests.swift
//  WeatherRxSwiftTests
//
//  Created by Nischal Hada on 19/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxTest
@testable import WeatherRxSwift
import XCTest

class CityListInteractorTests: QuickSpec {
    override func spec() {
        var testInteractor: CityListInteractor!
        var mockCityListHandler: MockStartCityListHandlerProtocol!
        var mockGetWeatherHandler: MockGetWeatherHandlerProtocol!
        var testScheduler: TestScheduler!

        describe("CityListInteractor") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockCityListHandler = MockStartCityListHandlerProtocol()
                stub(mockCityListHandler) { stub in
                    when(stub.getStartCityList()).thenReturn(Observable.error(RxError.noElements))
                }
                mockGetWeatherHandler = MockGetWeatherHandlerProtocol()
                stub(mockGetWeatherHandler) { stub in
                    when(stub.getWeatherInfo(by: any())).thenReturn(Observable.just(MocksInfo.weatherResult))
                    when(stub.getWeatherInfo(byCityIDs: any())).thenReturn(Observable.just(MocksInfo.citysWeatherResult))
                }
                testInteractor = CityListInteractor(withCityList: mockCityListHandler,
                                                    withGetWeather: mockGetWeatherHandler)
            }
            describe("Get city List from local file") {
                context("When get city list succeed") {
                    beforeEach {
                        stub(mockCityListHandler) { stub in
                            when(stub.getStartCityList()).thenReturn(Observable.just([MocksInfo.cityList]))
                        }
                        _ = testInteractor.getCityListFromFile().toBlocking(timeout: 2).materialize()
                    }
                    it("calls to the CityListHandler to get city info") {
                        verify(mockCityListHandler).getStartCityList()
                    }

                    it("emits city list info for updated citylist to the UI") {
                        let testObservable = testInteractor.getCityListFromFile().asObservable()
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, [MocksInfo.cityList]), Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    }
                }

                context("When get city list failed with error") {
                    beforeEach {
                        stub(mockCityListHandler) { stub in
                            when(stub.getStartCityList()).thenReturn(Observable.error(NetworkError.unknown))
                        }
                        _ = testInteractor.getCityListFromFile().toBlocking(timeout: 2).materialize()
                    }
                    it("calls to the CityListHandler to get city info") {
                        verify(mockCityListHandler).getStartCityList()
                    }

                    it("emits empty city list info for updated citylist to the UI") {
                        let testObservable = testInteractor.getCityListFromFile().asObservable()
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(2))
                        let correctResult: [Recorded<Event<[CityListModel]>>] = [Recorded.next(200, []), Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }

            describe("Get WeatherInfo for cityList") {
                context("when server request completes successfully") {
                    beforeEach {
                        stub(mockGetWeatherHandler) { stub in
                            when(stub.getWeatherInfo(byCityIDs: any())).thenReturn(Observable.just(MocksInfo.citysWeatherResult))
                        }
                        _ = testInteractor.getWeatherInfo(forCityList: [MocksInfo.cityList]).toBlocking(timeout: 2).materialize()
                    }
                    it("calls to the mockGetWeatherHandler to get weather info") {
                        let argumentCaptor = ArgumentCaptor<String>()
                        verify(mockGetWeatherHandler).getWeatherInfo(byCityIDs: argumentCaptor.capture())
                        let correctId = MocksInfo.cityList.id.map { String($0) }
                        expect(argumentCaptor.value).to(equal(correctId))
                    }
                    it("emits weather list to the UI to update list") {
                        let res = testScheduler.start { testInteractor.getWeatherInfo(forCityList: [MocksInfo.cityList]).asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, [MocksInfo.weatherResult]), Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    }
                }

                context("when server request fails with error") {
                    beforeEach {
                        stub(mockGetWeatherHandler) { stub in
                            when(stub.getWeatherInfo(byCityIDs: any())).thenReturn(Observable.error(testError1))
                        }
                        _ = testInteractor.getWeatherInfo(forCityList: [MocksInfo.cityList]).toBlocking(timeout: 2).materialize()
                    }
                    it("calls to the mockGetWeatherHandler to get weather info") {
                        let argumentCaptor = ArgumentCaptor<String>()
                        verify(mockGetWeatherHandler).getWeatherInfo(byCityIDs: argumentCaptor.capture())
                        let correctId = MocksInfo.cityList.id.map { String($0) }
                        expect(argumentCaptor.value).to(equal(correctId))
                    }
                    it("emits weather list to the UI to update list") {
                        let res = testScheduler.start { testInteractor.getWeatherInfo(forCityList: [MocksInfo.cityList]).asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult: [Recorded<Event<[WeatherResult]>>] = [Recorded.error(200, testError1)]
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }

            describe("fetch weather info for selected city from server") {
                context("when server request succeed ") {
                    beforeEach {
                        stub(mockGetWeatherHandler) { stub in
                            when(stub.getWeatherInfo(by: any())).thenReturn(Observable.just(MocksInfo.weatherResult))
                        }
                        _ = testInteractor.getWeatherInfo(forCity: MocksInfo.cityList).toBlocking(timeout: 2).materialize()
                    }
                    it("calls to the GetWeatherHandler to get weather info") {
                        let argumentCaptor = ArgumentCaptor<String>()
                        verify(mockGetWeatherHandler).getWeatherInfo(by: argumentCaptor.capture())
                        expect(argumentCaptor.value).to(equal(MocksInfo.cityList.name))
                    }
                    it("emits weather result to the UI to update list") {
                        let res = testScheduler.start { testInteractor.getWeatherInfo(forCity: MocksInfo.cityList).asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, MocksInfo.weatherResult), Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    }
                }

                context("when get city info request failed ") {
                    beforeEach {
                        stub(mockGetWeatherHandler) { stub in
                            when(stub.getWeatherInfo(by: any())).thenReturn(Observable.error(testError1))
                        }
                        _ = testInteractor.getWeatherInfo(forCity: MocksInfo.cityList).toBlocking(timeout: 2).materialize()
                    }
                    it("calls to the GetWeatherHandler to get weather info") {
                        let argumentCaptor = ArgumentCaptor<String>()
                        verify(mockGetWeatherHandler).getWeatherInfo(by: argumentCaptor.capture())
                        expect(argumentCaptor.value).to(equal(MocksInfo.cityList.name))
                    }
                    it("emits weather list to the UI to update list") {
                        let testObservable = testInteractor.getWeatherInfo(forCity: MocksInfo.cityList).asObservable()
                        let res = testScheduler.start { testObservable }
                        expect(res.events.count).to(equal(1))
                        let correctResult: [Recorded<Event<WeatherResult>>] = [Recorded.error(200, testError1)]
                        expect(res.events).to(equal(correctResult))
                    }
                }
            }
        }
    }
}

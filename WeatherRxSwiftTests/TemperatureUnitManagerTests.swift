//
//  TemperatureUnitManagerTests.swift
//  WeatherRxSwiftTests
//
//  Created by Nischal Hada on 14/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RxTest
import Cuckoo
@testable import WeatherRxSwift

final class TemperatureUnitManagerTests: QuickSpec {
    
    override func spec() {
        var testTemperatureUnitManager: TemperatureUnitManager!
        var mockUserDefaultsManager: MockUserDefaultsManagerProtocol!
        
        describe("TemperatureUnitManager") {
            beforeEach {
                mockUserDefaultsManager = MockUserDefaultsManagerProtocol()
                
                stub(mockUserDefaultsManager) { stub in
                    when(stub.set(value: any(), forKey: any())).thenDoNothing()
                    when(stub.string(forKey: any())).thenReturn("metric")
                }
                
                testTemperatureUnitManager = TemperatureUnitManager(mockUserDefaultsManager)
            }
            
            describe("When user set setTemperatureUnit") {
                context("When user set TemperatureUnit to celsius") {
                    beforeEach {
                        stub(mockUserDefaultsManager) { stub in
                            when(stub.set(value: any(), forKey: any())).thenDoNothing()
                        }
                        testTemperatureUnitManager.setTemperatureUnit(.celsius)
                    }
                    it("sets value in mockUserDefaultsManager set") {
                        let argumentCaptor = ArgumentCaptor<Any?>()
                        verify(mockUserDefaultsManager).set(value: argumentCaptor.capture(), forKey: "unit_type")
                        guard let value = argumentCaptor.value as? String else { fail("ArgumentCaptor value not found"); return}
                        expect(value).to(equal("metric"))
                    }
                }
                
                context("When user set TemperatureUnit to fahrenheit") {
                    beforeEach {
                        stub(mockUserDefaultsManager) { stub in
                            when(stub.set(value: any(), forKey: any())).thenDoNothing()
                        }
                        testTemperatureUnitManager.setTemperatureUnit(.fahrenheit)
                    }
                    it("sets value in mockUserDefaultsManager set") {
                        let argumentCaptor = ArgumentCaptor<Any?>()
                        verify(mockUserDefaultsManager).set(value: argumentCaptor.capture(), forKey: "unit_type")
                        guard let value = argumentCaptor.value as? String else { fail("ArgumentCaptor value not found"); return}
                        expect(value).to(equal("imperial"))
                    }
                }
            }
            
            describe("When get TemperatureUnit") {
                context("When TemperatureUnit is celsius") {
                    var result: SettingsUnit!
                    beforeEach {
                        stub(mockUserDefaultsManager) { stub in
                            when(stub.string(forKey: any())).thenReturn("metric")
                        }
                        result =  testTemperatureUnitManager.getTemperatureUnit()
                    }
                    it("return correct TemperatureUnit") {
                        expect(result).to(equal(.celsius))
                    }
                    it("call mockUserDefaultsManager for get string for key") {
                        verify(mockUserDefaultsManager).string(forKey: "unit_type")
                    }
                }
                
                context("When TemperatureUnit is fahrenheit") {
                    var result: SettingsUnit!
                    beforeEach {
                        stub(mockUserDefaultsManager) { stub in
                            when(stub.string(forKey: any())).thenReturn("imperial")
                        }
                        result =  testTemperatureUnitManager.getTemperatureUnit()
                    }
                    it("return correct TemperatureUnit") {
                        expect(result).to(equal(.fahrenheit))
                    }
                    it("call mockUserDefaultsManager for get string for key") {
                        verify(mockUserDefaultsManager).string(forKey: "unit_type")
                    }
                }
            }
        }
    }
}

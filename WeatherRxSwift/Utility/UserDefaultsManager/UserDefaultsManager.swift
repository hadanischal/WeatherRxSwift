//
//  UserDefaultsManager.swift
//  WeatherRxSwift
//
//  Created by Nischal Hada on 13/3/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//
// swiftlint:disable line_length

import Foundation

protocol UserDefaultsManagerProtocol {
    func set(value: Any?, forKey key: String)
    func object(forKey key: String) -> Any?
    func string(forKey key: String) -> String?
    func array(forKey key: String) -> [Any]?
    func dictionary(forKey key: String) -> [String: Any]?
    func data(forKey key: String) -> Data?
    func stringArray(forKey key: String) -> [String]?
    func integer(forKey key: String) -> Int
    func float(forKey key: String) -> Float
    func double(forKey key: String) -> Double
    func bool(forKey key: String) -> Bool
}

final class UserDefaultsManager: UserDefaultsManagerProtocol {
    /*!
     -setObject:forKey: immediately stores a value (or removes the value if nil is passed as the value) for the provided key in the search list entry for the receiver's suite name in the current user and any host, then asynchronously stores the value persistently, where it is made available to other processes.
     */
    func set(value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    /*!
     -objectForKey: will search the receiver's search list for a default with the key 'key' and return it. If another process has changed defaults in the search list, NSUserDefaults will automatically update to the latest values. If the key in question has been marked as ubiquitous via a Defaults Configuration File, the latest value may not be immediately available, and the registered value will be returned instead.
     */
    func object(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    /// -stringForKey: is equivalent to -objectForKey:, except that it will convert NSNumber values to their NSString representation. If a non-string non-number value is found, nil will be returned.
    func string(forKey key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }

    /// -arrayForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSArray.
    func array(forKey key: String) -> [Any]? {
        return UserDefaults.standard.array(forKey: key)
    }

    /// -dictionaryForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSDictionary.
    func dictionary(forKey key: String) -> [String: Any]? {
        return UserDefaults.standard.dictionary(forKey: key)
    }

    /// -dataForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSData.
    func data(forKey key: String) -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }

    /// -stringForKey: is equivalent to -objectForKey:, except that it will return nil if the value is not an NSArray<NSString *>. Note that unlike -stringForKey:, NSNumbers are not converted to NSStrings.
    func stringArray(forKey key: String) -> [String]? {
        return UserDefaults.standard.stringArray(forKey: key)
    }

    /*!
     -integerForKey: is equivalent to -objectForKey:, except that it converts the returned value to an NSInteger. If the value is an NSNumber, the result of -integerValue will be returned. If the value is an NSString, it will be converted to NSInteger if possible. If the value is a boolean, it will be converted to either 1 for YES or 0 for NO. If the value is absent or can't be converted to an integer, 0 will be returned.
     */
    func integer(forKey key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }

    /// -floatForKey: is similar to -integerForKey:, except that it returns a float, and boolean values will not be converted.
    func float(forKey key: String) -> Float {
        return UserDefaults.standard.float(forKey: key)
    }

    /// -doubleForKey: is similar to -integerForKey:, except that it returns a double, and boolean values will not be converted.
    func double(forKey key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }

    /*!
     -boolForKey: is equivalent to -objectForKey:, except that it converts the returned value to a BOOL. If the value is an NSNumber, NO will be returned if the value is 0, YES otherwise. If the value is an NSString, values of "YES" or "1" will return YES, and values of "NO", "0", or any other string will return NO. If the value is absent or can't be converted to a BOOL, NO will be returned.

     */
    func bool(forKey key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
}

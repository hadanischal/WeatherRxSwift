<p align="center">
<img src="ScreenShots/app_icon.png" alt="WeatherRxSwift for iOS" height="128" width="128">
</p>

<h1 align="center">WeatherRxSwift - Open Source Weather</h1>

## Requirements:
* iOS 13.0+
* Xcode 11.3.1
* Swift 5.0

## Compatibility
This demo is expected to be run using Swift 5.0 and Xcode 11.3.1

## Objective:
This is a simple Demo project which aims to display weather information using MVVM pattern in Swift. A fun app made with to demonstrate some examples of **clean architecture**, **SOLID principles** code organisation, loose coupling, **unit testing** and some of the best practices used in modern iOS programming using `Swift`.

## App Goal:
 - This project was intended to work as a  weather information demo projects for iOS using Swift.

## Implementation:
 - The demo uses the [Openweathermap API](http://api.openweathermap.org) as an excuse to have a nice use-case, because querying a WebService API is asynchronous by nature and is thus a good example for showing how It can be useful .
 - Use a UITableViewController to display weather information of Sydney, Melbourne and Brisbane as start.
 - Provide a way to add more cities using another modal view controller which includes a search functionality to find a city by name or location.
 - City IDs:
    - Sydney, Melbourne and Brisbane are: 4163971, 2147714, 2174003
 - More city can be found from  [Bulk Openweathermap API](http://bulk.openweathermap.org/sample/) 
 - Each cell should display at least two pieces of info: Name of city on the left, temperature on the right.
 - Get real time weather information using  [Openweathermap current API](https://openweathermap.org/current)  
 - A sample request to get weather info for one city: 
 - http://api.openweathermap.org/data/2.5/weather?id=4163971&units=metri c&APPID=your_registered_API_key
 - Weather should be automatically updated periodically.

## Installation

- Xcode **11.3**(required)
- Clean `/DerivedData` folder if any
- Run the pod install `pod install`
- Then clean and build the project in Xcode

## 3rd Party Libraries
 - **`RxSwift`** - to make `Reactive` binding of API call and response
 - **`SwiftLint`** - A tool to enforce Swift style and conventions. 
 - **`SwiftGen`** - swift code generator for your assets, storyboards, Localizable.strings. 
 - **`SwiftRichString`** - Elegant, easy and swift-like way to create Attributed Strings
 - **`PKHUD`** - Swift based reimplementation of the Apple HUD
 - **`Quick`** - to unit test as much as possible
 - **`Nimble`** - to pair with Quick
 - **`Cuckoo`** - Tasty mocking framework for unit tests in swift

 ## TODO:
 - Persist between launches
 - Flexible Design for multiple screen sizes.
 - Improve UI for good user interface, Keep the interface simple.
 - Cover edge case in Unit test
 - Add UI test

## Design patterns:
### MVVM:
MVVM stands for Model,View,ViewModel in which controllers, views and animations take place in View and Business logics, api calls take place in ViewModel. In fact this layer is interface between model and View and its going to provide data to View as it wants. 

![Alt text](/ScreenShots/MVVM.jpeg?raw=true)
 
#### App Demo

 ![](/ScreenShots/WeatherRxSwift.gif "")

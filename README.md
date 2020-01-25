<p align="center">
<img src="ScreenShots/app_icon.png" alt="WeatherZone for iOS" height="128" width="128">
</p>

<h1 align="center">WeatherZone - Open Source Weather</h1>

## Requirements:
* iOS 11.0+
* Xcode 10.2.1
* Swift 5.0

## Compatibility
This demo is expected to be run using Swift 5.0 and Xcode 10.2.1

## Objective:
This is a simple Demo project which aims to display weather information using MVVM pattern in Swift.
* This project was intended to work as a  weather information demo projects for iOS using Swift. 
* The demo uses the [Openweathermap API](http://api.openweathermap.org) as an excuse to have a nice use-case, because querying a WebService API is asynchronous by nature and is thus a good example for showing how It can be useful .
* Use a UITableViewController to display weather information of Sydney, Melbourne and Brisbane as start.
* Provide a way to add more cities using another modal view controller which includes a search functionality to find a city by name or location.
* City IDs:
* Sydney, Melbourne and Brisbane are: 4163971, 2147714, 2174003
* More city can be found from  [Bulk Openweathermap API](http://bulk.openweathermap.org/sample/) 
* Each cell should display at least two pieces of info: Name of city on the left, temperature on the right.
* Get real time weather information using  [Openweathermap current API](https://openweathermap.org/current)  
* A sample request to get weather info for one city: 
* http://api.openweathermap.org/data/2.5/weather?id=4163971&units=metri c&APPID=your_registered_API_key
* Weather should be automatically updated periodically.

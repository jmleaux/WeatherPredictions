//
//  Constants.swift
//  WeatherPrediction
//
//  Created by J. M. Lowe on 3/30/17.
//  Copyright © 2017 JMLeaux LLC. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let DAILY_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat="
let LONGITUDE = "lon="
let APP_ID = "appid="
let API_KEY = "b65b7255aeaf3e0d373c29f20cd235e6"
let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)&\(LONGITUDE)\(Location.sharedInstance.longitude!)&\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(DAILY_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)&\(LONGITUDE)\(Location.sharedInstance.longitude!)&cnt=10&mode=json&\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()

func kelvinToCelsius(_ kelvinTemp:Double) -> Double {
    return(kelvinTemp - 273.15)
}

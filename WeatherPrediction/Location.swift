//
//  Location.swift
//  WeatherPrediction
//
//  Created by J. M. Lowe on 5/7/17.
//  Copyright © 2017 JMLeaux LLC. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() { }
    
    var latitude: Double!
    var longitude: Double!
    
}

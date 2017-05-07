//
//  WeatherVC.swift
//  WeatherPrediction
//
//  Created by J. M. Lowe on 3/24/17.
//  Copyright © 2017 JMLeaux LLC. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
//    var forecast = Forecast()
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
//        forecast = Forecast()
        
        currentWeather.downloadWeatherDetails {
            print("about to call self.updateMainUI")
            self.downloadForecastData {
                self.updateMainUI()
            }
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
//        downloading forecast weather data for table view
//        let forecastURL = URL(string: FORECAST_URL)
//        Alamofire.request(forecastURL).respon
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)    // need to remove first forecast because that is TODAY's forecast
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }

    // the three functions below are REQUIRED whenever we are using UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCellTableViewCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        }
        return WeatherCellTableViewCell()
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(format: "%.1f", currentWeather.currentTemp) + "°C"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        cityLabel.text = currentWeather.cityName
        print(currentWeather.cityName)
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
}


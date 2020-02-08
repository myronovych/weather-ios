//
//  WeatherManager.swift
//  Clima
//
//  Created by Myronovych Sasha on 07.12.2019.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didEndWithError(error: Error)
}

protocol WeatherManagerDelegateCell {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel, cityCell: CityCellTableViewCell)
    func didEndWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=49687861f04b11f634f7849aacbc5bc5&units=metric"
    
    var delagate: WeatherManagerDelegate?
    var delegate: WeatherManagerDelegateCell?
    func getCityWeather(city: String){
        let weatherString = weatherURL + "&q=" + (city)
        performRequest(url: weatherString)
    }
    
    func getCityWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let weatherString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(url: weatherString)
    }
    
    func performRequest(url : String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delagate?.didEndWithError(error: error!)
                    self.delegate?.didEndWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather, cityCell: <#CityCellTableViewCell#>)
                            self.delagate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weatherID = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weatherModel = WeatherModel(weatherID: weatherID, temperature: temp, cityName: name)
            return weatherModel
        } catch {
            print(error)
            return nil
        }
    }

}

//
//  WeatherManager.swift
//  Clima
//
//  Created by Myronovych Sasha on 07.12.2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=49687861f04b11f634f7849aacbc5bc5&units=metric&q="
    
    var delagate: WeatherManagerDelegate?
    
    func getCityWeather(city: String){
        let weatherString = weatherURL + (city)
        performRequest(url: weatherString)
    }
    
    func performRequest(url : String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delagate?.didUpdateWeather(weather: weather)
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

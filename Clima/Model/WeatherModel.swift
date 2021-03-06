//
//  WeatherModel.swift
//  Clima
//
//  Created by Myronovych Sasha on 07.12.2019.
//

import Foundation

struct WeatherModel {
    let weatherID: Int
    let temperature: Double
    let cityName: String
    var temp: String {
        return String(format: "%.1f", temperature)
    }
    var temperatureString: String {
        switch weatherID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
            
        }
    }
}

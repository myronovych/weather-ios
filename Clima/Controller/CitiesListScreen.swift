//
//  CitiesListScreen.swift
//  Clima
//
//  Created by Myronovych Sasha on 01.02.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

class CitiesListScreen: UIViewController {
    var weatherManager = WeatherManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    var cities: [WeatherModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = createCities()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createCities()->[WeatherModel]{
        var cities: [WeatherModel] = []
        let city1 = WeatherModel(weatherID: 202,temperature: 2,cityName: "Kiev")
        let city2 = WeatherModel(weatherID: 202,temperature: 3,cityName: "Pivo")
        let city3 = WeatherModel(weatherID: 202,temperature: 4,cityName: "Lviv")
        cities.append(city1)
        cities.append(city2)
        cities.append(city3)
        return cities
    }
}



extension CitiesListScreen: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row ]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityCellTableViewCell
        cell.setCityWeather(city: city)
        return cell
    }
    
    
}



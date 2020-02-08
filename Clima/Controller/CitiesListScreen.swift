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
    
    var cities: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = createCities()
        tableView.delegate = self
        tableView.dataSource = self
        weatherManager.delegate = self
    }
    
    func createCities()->[String]{
        let cities: [String] = ["Kyiv","Lviv","London"]
        return cities
    }
}



extension CitiesListScreen: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city: String = cities[indexPath.row]
        weatherManager.getCityWeather(city: city)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityCellTableViewCell
        
        return cell
    }
    
    
}

extension CitiesListScreen: WeatherManagerDelegateCell {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel, cityCell: CityCellTableViewCell){
        DispatchQueue.main.async {
            cityCell.setCityWeather(city: weather)
        }
    }
    
    func didEndWithError(error: Error) {
        print(error)
    }
}

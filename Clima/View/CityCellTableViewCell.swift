//
//  CityCellTableViewCell.swift
//  Clima
//
//  Created by Myronovych Sasha on 01.02.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

class CityCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    func setCityWeather(city: WeatherModel){
        cityLabel.text = city.cityName
        tempLabel.text = city.temp
        
    }
}

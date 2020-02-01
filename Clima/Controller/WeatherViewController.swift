
import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delagate = self
        searchField.delegate = self
    }
    
       @IBAction func locationWeather(_ sender: UIButton) {
        locationManager.requestLocation()
       }

    
    @IBAction func savedCititesPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSavedCities", sender: self)
    }
    
    
}

extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchField.endEditing(true)
        print(searchField.text!)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type city"
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        print(searchField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.getCityWeather(city: searchField.text!)
        searchField.text = ""
        
    }
}

extension WeatherViewController: WeatherManagerDelegate {    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temp
            self.conditionImageView.image = UIImage(systemName: weather.temperatureString)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didEndWithError(error: Error) {
        print(error)
    }
}

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print(error)
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
        locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.getCityWeather(latitude: lat, longitude: long)
        }
}

}

//
//  ApiCall.swift
//  SunriseDetector
//
//  Created by Lex Tamas on 2022. 05. 02..
//

import Foundation
import MapKit


struct WeatherApi {
    
    static let api = WeatherApi()
    
    
    let locationManager: CLLocationManager
    let base = URL(string:"https://api.openweathermap.org/data/2.5/")!
    let key = "9d2f52cd3e112621185f95953a74699f"
    let decoder = JSONDecoder()
    
    struct LocationCoordinates{
        
        let lat: Double
        let lon: Double

    }
    
    init(){
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()

    }
    
    func getCurrentData(completionHandler: @escaping (Current) -> Void) {
        
        let queryURL = base.appendingPathComponent("onecall")
        
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
    
        components?.queryItems = [URLQueryItem(name: "appid", value: key)]
        components?.queryItems?.append(URLQueryItem(name:"lat",value:String(self.getCityLocation().lat)))
        components?.queryItems?.append(URLQueryItem(name:"lon",value:String(self.getCityLocation().lon)))
        components?.queryItems?.append(URLQueryItem(name:"exlude",value:"hourly,minutely,alerts"))
        components?.queryItems?.append(URLQueryItem(name:"units",value:"metric"))
    
        if let url = components?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error with fetching: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
                  }
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                   print("NO DATA")
                }
                return
            }
               
               do {
                
              
                let ret = try self.decoder.decode(Current.self, from: data)
                
                completionHandler(ret)
                
        
               } catch let error {
          
                    print("JSON decoding Error: \(error)")

               }
                
            }
            
            task.resume()

        }
        
    }
    
    func getForecastData(completionHandler: @escaping (Forecast) -> Void) {
        
        let queryURL = base.appendingPathComponent("onecall")
        
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
    
        components?.queryItems = [URLQueryItem(name: "appid", value: key)]
        components?.queryItems?.append(URLQueryItem(name:"lat",value:String(self.getCityLocation().lat)))
        components?.queryItems?.append(URLQueryItem(name:"lon",value:String(self.getCityLocation().lon)))
        components?.queryItems?.append(URLQueryItem(name:"exlude",value:"hourly,minutely,alerts"))
        components?.queryItems?.append(URLQueryItem(name:"units",value:"metric"))
    
        if let url = components?.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error with fetching: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
                  }
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                   print("NO DATA")
                }
                return
            }
               
               do {                
              
                let ret = try self.decoder.decode(Forecast.self, from: data)
                
                completionHandler(ret)
                
        
               } catch let error {
          
                    print("JSON decoding Error: \(error)")

               }
                
            }
            
            task.resume()

        }
        
    }
    
    
    private func getCityLocation() -> LocationCoordinates {
        
        var currentCity : LocationCoordinates = LocationCoordinates(lat:47.497913,lon:19.040236)
        
        if CLLocationManager.locationServicesEnabled(), let location = locationManager.location {
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                
                currentCity = LocationCoordinates(lat: location.coordinate.latitude.rounded(), lon: location.coordinate.longitude.rounded())
            }
            
        }
        
        return currentCity
        
    }
        
}

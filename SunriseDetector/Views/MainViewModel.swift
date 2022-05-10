//
//  MainViewModel.swift
//  SunriseDetector
//
//  Created by Lex Tamas on 2022. 05. 02..
//

import Foundation

class MainViewModel : ObservableObject{
    
    @Published var currentData : Current
    @Published var forecast : Forecast
    
    private var notification : NotificationHandler
    
    var cloudImageResource : String {
        
        return self.getCloudImage(cloudValue:currentData.current.clouds)
    }
    
    init(){
        
         notification = NotificationHandler()
        
        
        self.currentData = Current(timezone: "NULL",lat: 0 , lon: 0, current: Day(sunrise: 10, temp: 10,clouds: 0))
        self.forecast = Forecast(timezone: "NULL", daily: [ForecastDay]())
        
        WeatherApi.api.getCurrentData { current in
            
            DispatchQueue.main.async {
                
                self.currentData = current
            }
           
        }
        
        WeatherApi.api.getForecastData { forecast in
            
            DispatchQueue.main.async {
                
                self.forecast = forecast
                self.forecast.daily.removeFirst() //Removes the current day
                
                self.notification.setupDailyNotification(forecast: self.forecast)
                self.notification.welcomeNotification(forecast: self.forecast)
            }
           
        }
        
    }
    
    
    func getCloudImage(cloudValue : Double) -> String {
        
        if(cloudValue < 50){
            return "sunrise"
        }
        else{
            return "clouds"
        }
    }
    
    func getCloudText(cloudValue: Double) -> String {
        
        
        if(cloudValue < 50){
            return "It's going to be less than 50% chance to be cloudy. It's worth a shot to wake up!"
        }
        else{
            return "It's going to be cloudy, you should rather sleep!"
        }
        
    }
    
    func getWeatherDescription(value: String?) -> String {
        
        if(value != nil){
            return "Further weather description: " + value!
        }else{
            return "No description available!"
        }
        
    }
}

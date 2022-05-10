//
//  Day.swift
//  SunriseDetector
//
//  Created by Lex Tamas on 2022. 05. 02..
//

import Foundation


struct Day : Codable {
        
    let sunrise: TimeInterval
    let temp: Double
    let clouds : Double
    
    var tempString : String {
        return String(format: "%.02f C°" , temp)
    }
    
    var sunRiseString : String{
        
        let date = Date(timeIntervalSince1970: self.sunrise)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "HH:mm"
        let localDate = dateFormatter.string(from: date)
        
        return localDate
    }
    
    
}

struct ForecastDay : Codable{
    
    let sunrise: TimeInterval
    let clouds : Double
    
    struct Temperature : Codable{
        let morn: Double
    }
    
    let temp: Temperature
    
    
    struct Weather: Codable{
        
        let description : String
    }
    
    let weather: [Weather]
    
    var tempString : String {
        return String(format: "%.02f C°" , temp.morn)
    }
    
    var sunRiseString : String{
        
        let date = Date(timeIntervalSince1970: self.sunrise)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "MMM d. HH:mm"
        let localDate = dateFormatter.string(from: date)
        
        return localDate
    }
    
}

extension ForecastDay : Identifiable {
    var id: UUID { return UUID() }
    
}

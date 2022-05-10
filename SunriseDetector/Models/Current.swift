//
//  Current.swift
//  SunriseDetector
//
//  Created by Lex Tamas on 2022. 05. 02..
//

import Foundation

struct Current: Codable {

    let timezone: String
    
    let lat: Double
    let lon: Double
    
    var locationString : String {
        
        return String(format: "%.02f lat : %.02f lon",lat,lon)
    }
    
    let current: Day

}

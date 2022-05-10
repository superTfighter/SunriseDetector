//
//  ForecastModel.swift
//  SunriseDetector
//
//  Created by Lex Tamas on 2022. 05. 02..
//

import Foundation


struct Forecast: Codable {

    let timezone: String
    
    var daily: Array<ForecastDay>
}

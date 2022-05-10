//
//  ForecastView.swift
//  SunriseDetector
//
//  Created by Lex Tamas on 2022. 05. 03..
//

import SwiftUI

struct ForecastView : View {
    
    @ObservedObject var viewModel : MainViewModel
    
    let forecastDay: ForecastDay
    
    init(viewModel: MainViewModel,forecastDay: ForecastDay){
        
        self.forecastDay = forecastDay
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        if(viewModel.currentData.timezone == "NULL"){
            
            LoadingView()
        }
        else{
            VStack(){
                VStack(){
                    
                    Text("Morning temperature:")
                    Text(forecastDay.tempString).font(.largeTitle).fontWeight(.bold)
                    Text("Sunrise time:")
                    Text(forecastDay.sunRiseString).font(.title)
                    

                }.frame(

                    minWidth: 0,

                    maxWidth: .infinity,

                    minHeight: 0,

                    maxHeight: .infinity,

                    alignment: .center

                ).background(Image(viewModel.getCloudImage(cloudValue: forecastDay.clouds)).resizable()).ignoresSafeArea()
                
                VStack(alignment: .center){
                    Text(viewModel.getCloudText(cloudValue: forecastDay.clouds)).bold().font(.title2)
                    Text(viewModel.getWeatherDescription(value: forecastDay.weather.first?.description)).font(.title2)
                }.background(Color.white)
                
            }
            
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: MainViewModel(),forecastDay: ForecastDay(sunrise: 0, clouds: 0, temp: ForecastDay.Temperature(morn: 0),weather:[ForecastDay.Weather]()))
    }
}

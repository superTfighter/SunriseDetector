//
//  ContentView.swift
//  SunriseDetector
//
//  Created by Lex Tamas on 2022. 05. 02..
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel){
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        if(viewModel.currentData.timezone == "NULL" || viewModel.forecast.timezone == "NULL"){
            LoadingView()
        }else{
            
            NavigationView {
            
                    VStack{
                        VStack(){
            
                            Text(viewModel.currentData.current.tempString).font(.largeTitle).fontWeight(.bold)
                            Text("Sunrise time:")
                            Text(viewModel.currentData.current.sunRiseString).font(.title)
                            Text("Position:")
                            Text(viewModel.currentData.locationString).font(.title)
            
                        }.frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: .center
                        ).background(Image(viewModel.cloudImageResource).resizable()).ignoresSafeArea()
            
                        List(viewModel.forecast.daily){ f in
            
            
                            NavigationLink(destination: ForecastView(viewModel: viewModel, forecastDay: f )) {
            
                                Text("Sunrise time:")
                                Text(f.sunRiseString)
                                Text("Temp:")
                                Text(f.tempString)
            
                            }
                        }
                    }
                
            }.navigationBarTitle("Sunride Detector")
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}

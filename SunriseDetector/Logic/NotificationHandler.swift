//
//  NotificationHandler.swift
//  SunriseDetector
//
//  Created by Lex Tamas on 2022. 05. 05..
//

import Foundation
import UserNotifications

class NotificationHandler {
    
    
    init(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Notification set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func welcomeNotification(forecast: Forecast){
        
        let f = forecast.daily.first
        
        if(f != nil){
        
        let content = UNMutableNotificationContent()
        content.title = "Your next sunrise alert!"
        content.subtitle = "Your next sunrise will be: " + f!.sunRiseString
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
            
        }
    }
    
    func setupDailyNotification(forecast: Forecast){
        
        let f = forecast.daily.first
        
        if(f != nil){
            
            let content = UNMutableNotificationContent()
            content.title = "Your next sunrise alert!"
            content.subtitle = "Your next sunrise will be: " + f!.sunRiseString
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            dateComponents.hour = 20
            
            // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(
                     dateMatching: dateComponents, repeats: true)
            
            
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                        content: content, trigger: trigger)

            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
               if error != nil {
                print(error.debugDescription)
               }
            }
            
            
        }
        
    }
    
    
}

//
//  NotificationViewModel.swift
//  pokedex
//
//  Created by Kevin Dallian on 23/05/24.
//

import Foundation
import UserNotifications

class NotificationViewModel : ObservableObject {
    func requestAuthorization() async{
        let options = UNAuthorizationOptions([.alert, .badge, .sound])
        do{
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: options)
            if granted {
                await registerNotification()
            }
        } catch {
            print("Error requesting authorization : \(error.localizedDescription)")
        }
    }
    
    func registerNotification() async {
        let content = UNMutableNotificationContent()
        content.title = "Pokemon"
        content.body = "Gotta catch em all!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 6
        dateComponents.weekday = 1
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        do{
            try await UNUserNotificationCenter.current().add(request)
        } catch{
            print("Error registering notification :\(error.localizedDescription)")
        }
    }
}

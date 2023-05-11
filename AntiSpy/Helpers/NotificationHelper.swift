//
//  NotificationHelper.swift
//  AntiSpy
//
//  Created by Rome on 4/23/23.
//

import Foundation
import UIKit
import UserNotifications

func makeNotification(title: String, body: String, identifier: String) {
    // Request permission to display notifications
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if let error = error {
            // Handle the error
            print("Error requesting authorization for notifications: \(error.localizedDescription)")
        }
        
        if granted {
            // Register the app for remote notifications
            DispatchQueue.main.async {
                
                UIApplication.shared.registerForRemoteNotifications()
                
            }
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            
            let req = UNNotificationRequest(identifier: "Notification#"+identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
        }
    }

   
}
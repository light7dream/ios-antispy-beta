//
//  BackgroundTaskService.swift
//  AntiSpy
//
//  Created by Rome on 4/23/23.
//
import Foundation

import UIKit

class BackgroundTaskService {
    
    static let shared = BackgroundTaskService()
    static var clickId = ""
    static var isCamera = true
    static var isMicrophone = false
    static var isLocation = false
    static var enNotification = false
    static var enVibration = false
    static var enFilter = false
    var filter = false;
    var timer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    func scheduleBackgroundTask(serviceType: String) {
        print("Camera => ", BackgroundTaskService.isCamera)
        print("Location => ", BackgroundTaskService.isLocation)
        print("Microphone => ", BackgroundTaskService.isMicrophone)

        // Register the background task with the system, and start a new task
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BackgroundTask") {
            // Handle the expiration of the background task.
//            self.cancelBackgroundTask(serviceType: serviceType)
        }

       // Schedule the task to run every 30 seconds (adjust as needed)
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in

            // Handle your background task logic here
        
            if(BackgroundTaskService.isLocation) {
                getAppsUsingLocation()
                print("Background Task is running for location.")
            }
            
            if(BackgroundTaskService.isCamera) {
                getAppsUsingCamera()
                print("Background Task is running for camera.")
            }
            
            if(BackgroundTaskService.isMicrophone) {
                getAppsUsingMicrophone()
                print("Backgound Task is running for microphone.")
            }
                        
            if(BackgroundTaskService.enFilter == true){
//                if(BackgroundTaskService.enFilter != self.filter){
//                    self.filter = true
                    DatabaseHelper.shared.fresh(en: true)
                    print("Delete Activities after 2 days has been enabled.")
//                }
            } else {
//                if(BackgroundTaskService.enFilter != self.filter){
//                    self.filter = false
                    DatabaseHelper.shared.fresh(en: false)
                    print("Delete Activities after 2 days has been disabled.")
//                }
            }
        }
        RunLoop.current.add(timer!, forMode: .default)
        
        // Cancel any previous background task
//        cancelBackgroundTask(serviceType: serviceType)
    }

    func cancelBackgroundTask(serviceType: String) {
        timer?.invalidate()
        timer=nil
        if backgroundTask != .invalid {
            DispatchQueue.main.async {
                UIApplication.shared.endBackgroundTask(self.backgroundTask)
            }
            backgroundTask = .invalid
            print("Background task stopped")
            switch(serviceType) {
            case "camera":
                BackgroundTaskService.isCamera = false
                return
            case "microphone":
                BackgroundTaskService.isMicrophone = false
                return
            case "location":
                BackgroundTaskService.isLocation = false
                return
            default:
                return
            }
        }
    }
    
}


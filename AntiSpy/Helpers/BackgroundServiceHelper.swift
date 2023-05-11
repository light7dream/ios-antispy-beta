//
//  BackgroundServiceHelper.swift
//  AntiSpy
//
//  Created by Rome on 4/21/23.
//

import Foundation
import BackgroundTasks



func scheduleBackgroundTask() {
    let request = BGAppRefreshTaskRequest(identifier: "com.example.backgroundtask")
    request.earliestBeginDate = Date(timeIntervalSinceNow: 60.0)
    
    do {
        try BGTaskScheduler.shared.submit(request)
    } catch {
        print("Unable to submit task: \(error.localizedDescription)")
    }
}

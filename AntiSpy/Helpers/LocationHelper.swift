//
//  LocationHelper.swift
//  MyApplication
//
//  Created by Rome on 4/13/23.
//

import Foundation
import CoreLocation
import UIKit
import SwiftUI

func getAppsUsingLocation() {
    
    let locationManager = CLLocationManager()
    locationManager.requestWhenInUseAuthorization()
  
    for app in Bundle.allBundles {

        let hasLocationAlwaysUsageDescription = app.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") != nil
        let hasLocationWhenInUseUsageDescription = app.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil
        
        if hasLocationAlwaysUsageDescription || hasLocationWhenInUseUsageDescription {
            let appName = app.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
            
            let iconName = app.object(forInfoDictionaryKey: "CFBundleIconFile") as? String ?? ""
            
            DatabaseHelper.shared.doWork(activity: Activity(startDate: "", startTime: "", name: appName, iconName: iconName, serviceName: "LocationIconImage", period: ""))
            
        }

    }
    
}
// //
// //  LocationHelper.swift
// //  MyApplication
// //
// //  Created by Rome on 4/13/23.
// //

// import Foundation
// import CoreLocation
// import UIKit
// import SwiftUI

// func getAppsUsingLocation() {
    
//     let locationManager = CLLocationManager()
//     locationManager.requestWhenInUseAuthorization()
  
//     for app in Bundle.allBundles {

//         let hasLocationAlwaysUsageDescription = app.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") != nil
//         let hasLocationWhenInUseUsageDescription = app.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil
        
//         if hasLocationAlwaysUsageDescription || hasLocationWhenInUseUsageDescription {
//             let appName = app.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
            
//             let iconName = app.object(forInfoDictionaryKey: "CFBundleIconFile") as? String ?? ""
            
//             DatabaseHelper.shared.doWork(activity: Activity(startDate: "", startTime: "", name: appName, iconName: iconName, serviceName: "LocationIconImage", period: ""))
            
//         }

//     }
    
// }

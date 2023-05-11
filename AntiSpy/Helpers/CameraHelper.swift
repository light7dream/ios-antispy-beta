//
//  CameraHelper.swift
//  AntiSpy
//
//  Created by Rome on 4/23/23.
//

import Foundation
import AVFoundation

func getAppsUsingCamera() {
    
    let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInUltraWideCamera], mediaType: .video, position: .unspecified)
    
    for _ in discoverySession.devices {
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String,
            AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            // Check if the device has an authorized status
            var iconName:String = ""
            if let iconsDict = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
               let primaryIconsDict = iconsDict["CFBundlePrimaryIcon"] as? [String: Any],
               let iconFiles = primaryIconsDict["CFBundleIconFiles"] as? [String],
               let lastIcon = iconFiles.last {
                    iconName=lastIcon
//                   let iconImage = UIImage(named: lastIcon)
                   // do something with the icon image...
            }
            DatabaseHelper.shared.doWork(activity: Activity(startDate: "", startTime: "", name: appName, iconName: iconName, serviceName: "CameraWhiteIconImage", period: ""))
            
        }
    }
    
}


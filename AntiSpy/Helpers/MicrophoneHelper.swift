//
//  MicrophoneHelper.swift
//  AntiSpy
//
//  Created by Rome on 4/24/23.
//

import Foundation
import AVFoundation

func getAppsUsingMicrophone() {
    
    let session = AVAudioSession.sharedInstance()
    let currentRoute = session.currentRoute
    
    for outputPort in currentRoute.outputs {
        if outputPort.portType == .builtInMic || outputPort.portType == .headsetMic {
            // Check if the built-in or headset microphone is selected as the audio input route
            
            let appDescriptions = session.availableInputs?.compactMap { $0.portName } ?? []
            
            for description in appDescriptions {
                if !description.contains("iPhone Microphone") && !description.contains("Headset Microphone") {
                    // Assume that any app with a port name that doesn't contain "iPhone Microphone" or "Headset Microphone"
                    // has requested microphone access
                    var iconName:String = ""
                    let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
                    if let iconsDict = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
                       let primaryIconsDict = iconsDict["CFBundlePrimaryIcon"] as? [String: Any],
                       let iconFiles = primaryIconsDict["CFBundleIconFiles"] as? [String],
                       let lastIcon = iconFiles.last {
                            iconName = lastIcon
        //                   let iconImage = UIImage(named: lastIcon)
                           // do something with the icon image...
                    }
                    DatabaseHelper.shared.doWork(activity: Activity(startDate: "", startTime: "", name: appName, iconName: iconName, serviceName: "MicroPhoneIconImage", period: ""))
                
                }
            }
        }
    }
}

//
//  SideMenu.swift
//  AntiSpy
//
//  Created by Rome on 4/17/23.
//

import Foundation

enum SideMenuRowType: Int, CaseIterable {
//    case settings = 1
//    case share
    case activity = 1
//    case privacy
    case cancelSubscription
    
    var title: String {
        switch self {
//        case .settings:
//            return "Settings"
//        case .share:
//            return "Share"
        case .activity:
            return "Activity"
//        case .privacy:
//            return "Privacy"
        case .cancelSubscription:
            return "CancelSubscription"
        }
    }
    
    var iconName: String {
        switch self {
//        case .settings:
//            return "SettingsIconImage"
//        case .share:
//            return "ShareIconImage"
        case .activity:
            return "RateIconImage"
//        case .privacy:
//            return "PrivacyIconImage"
        case .cancelSubscription:
            return "CancelSubscriptionIconImage"
        }
    }
}

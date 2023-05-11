//
//  TabView.swift
//  AntiSpy
//
//  Created by Rome on 4/18/23.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedSideMenuTab) {
                HomePage(presentSideMenu: $presentSideMenu)
                    .tag(0)
//                SettingsView(presentSideMenu: $presentSideMenu)
//                    .tag(1)
//                ShareView(presentSideMenu: $presentSideMenu)
//                    .tag(2)
                RateView(presentSideMenu: $presentSideMenu)
                    .tag(1)
//                PrivacyPolicyView(presentSideMenu: $presentSideMenu)
//                    .tag(4)
                CancelSubscriptionView(presentSideMenu: $presentSideMenu)
                    .tag(2)
            }
            
            SideMenuContainerView(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
        .frame(alignment: .top)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("Tab View")
        
        MainTabView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("Tab View(2)")
        
        MainTabView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("Tab View(3)")
    }
}

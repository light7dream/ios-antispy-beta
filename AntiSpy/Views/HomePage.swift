
//
//  HomePage.swift
//  AntiSpy
//
//  Created by Rome on 4/16/23.
//

import Foundation
import SwiftUI

struct HomePage: View {
    @Binding var presentSideMenu: Bool
    @State var isCamera = true
    @State var isMicrophone = false
    @State var isLocation = false
    @State var startPageTab: Int? = nil
    var activities : [Activity] = DatabaseHelper.shared.getAll()
    var activities_: [Activity] = [
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Facebook", iconName: "FacebookLogoImage", serviceName: "LocationIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Call", iconName: "CallLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Camera", iconName: "CameraHomeLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Twitter", iconName: "TwitterLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30")
    ]
    var body: some View {
        GeometryReader { geometry in
//            ScrollView {
                ZStack {
                    VStack() {
                        ZStack {
                            VStack() {
                                ZStack() {
                                    Image("HomePageLogo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2 - 80)
                                    VStack() {
                                        Text("Welcome L.")
                                            .font(.system(size: 32))
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 2 - 150, alignment: .bottomLeading)
                                    .padding(.horizontal, 30)
                                }
                            }
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .top)
                            VStack() {
                                Button(action: {
                                    presentSideMenu.toggle()
                                }) {
                                    Image("NavIconImage")
                                }
                            }
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
                            .padding(.horizontal, 20)
                            .padding(.top, 40)
                        }
                        
                        GeometryReader { geo in
                            ZStack {
                                if(self.activities.count > 0) {
                                    ScrollView() {
                                        ForEach(self.activities, id: \.self) {activity in
                                            if((self.isCamera == true && activity.serviceName == "CameraWhiteIconImage") || (self.isMicrophone == true && activity.serviceName == "MicroPhoneIconImage") || (self.isLocation == true && activity.serviceName == "LocationIconImage")) {
                                                HStack() {
                                                    VStack() {
                                                        Text(activity.startDate)
                                                            .font(.system(size: 14))
                                                            .foregroundColor(Color("GrayColor"))
                                                        Text(activity.startTime)
                                                            .font(.system(size: 14))
                                                            .foregroundColor(Color("GrayColor"))
                                                    }
                                                    Spacer()
                                                    Image(activity.iconName)
                                                    Spacer()
                                                    Text(activity.name)
                                                        .font(.system(size: 16))
                                                        .foregroundColor(.white)
                                                    Spacer()
                                                    Image(activity.serviceName)
                                                    Spacer()
                                                    Text(activity.period)
                                                        .font(.system(size: 12))
                                                        .foregroundColor(Color("GrayColor"))
                                                }
                                                .frame(maxWidth: geo.size.width, alignment: .leading)
                                                .padding(.horizontal, 20)
                                                
                                                Divider()
                                                    .frame(height: 2)
                                                    .overlay(Color("DividerBackgroundColor"))
                                                    .padding(.horizontal, 20)
                                                    .padding(.vertical, 10)
                                            }
                                        }
                                    }
                                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height / 2 + 150, alignment: .top)
                                    .padding(.top, geo.safeAreaInsets.top - 30)
                                } else {
                                    VStack(spacing: 15.0) {
                                        Image("StartActivityLogoImage")
                                        
                                        Text("No camera activity yet.")
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("GrayColor"))
                                        
                                        Text("No microphone activity yet.")
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("GrayColor"))
                                        
                                        Text("No location activity yet.")
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("GrayColor"))
                                        
                                        NavigationLink(destination: StartView(), tag: 2, selection: $startPageTab) {
                                            Button(action: {
                                                self.startPageTab = 2
                                            }) {
                                                HStack() {
                                                    Text("Start Activity")
                                                        .font(.system(size: 16))
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal, 25)
                                                        .padding(.vertical, 15)
                                                        
                                                }
                                                .background(LinearGradient(gradient: Gradient(colors: [Color("StartActivityButtonBackgroundColor"), Color("StartActivityButtonBackgroundColor")]), startPoint: .top, endPoint: .bottom))
                                                .cornerRadius(50)
                                            }
                                        }
                                    }
                                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height / 2 + 130, alignment: .top)
                                    .padding(.top, geo.safeAreaInsets.top - 50)
                                }
                                
                                HStack() {
                                    HStack(spacing: 70.0) {
                                        Button(action: {
                                            self.isCamera = !self.isCamera
                                            if(self.isCamera == true) {
                                                self.isMicrophone = false
                                                self.isLocation = false
                                            }
                                        }) {
                                            if(self.isCamera == true) {
                                                Image("CameraIconImage")
                                            } else if(self.isCamera == false) {
                                                Image("CameraIconImage")
                                                    .opacity(0.5)
                                            }
                                        }
                                        
                                        Button(action: {
                                            self.isMicrophone = !self.isMicrophone
                                            if(self.isMicrophone == true) {
                                                self.isCamera = false
                                                self.isLocation = false
                                            }
                                        }) {
                                            if(self.isMicrophone == true) {
                                                Image("AudioLogoImage")
                                            } else if(self.isMicrophone == false) {
                                                Image("AudioLogoImage")
                                                    .opacity(0.5)
                                            }
                                        }
                                        
                                        Button(action: {
                                            self.isLocation = !self.isLocation
                                            if(self.isLocation == true) {
                                                self.isMicrophone = false
                                                self.isCamera = false
                                            }
                                        }) {
                                            if(self.isLocation == true) {
                                                Image("LocationLogoImage")
                                            } else if(self.isLocation == false) {
                                                Image("LocationLogoImage")
                                                    .opacity(0.5)
                                            }
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                }
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color("ServicesBackgroundColor"), Color("ServicesBackgroundColor")]), startPoint: .top, endPoint: .bottom)
                                )
                                .cornerRadius(50)
                                .padding()
                                .padding(.top, geo.size.height / 2 + 80)
                            }
                        }
                    }
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("StartPageBackgroundColor"), Color("StartPageBackgroundColor")]), startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea(edges: .vertical)
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("Home Page")
        
        HomePage(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("Home Page (2)")
        
        HomePage(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("Home Page (3)")
    }
}

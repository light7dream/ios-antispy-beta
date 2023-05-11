
//
//  RateView.swift
//  AntiSpy
//
//  Created by Rome on 4/18/23.
//

import Foundation
import SwiftUI

struct RateView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Binding var presentSideMenu: Bool
    @State var startPageTab: Int? = nil
    var activities : [Activity] = DatabaseHelper.shared.getAll()
    var activities_: [Activity] = [
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Facebook", iconName: "FacebookLogoImage", serviceName: "LocationIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Call", iconName: "CallLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Camera", iconName: "CameraHomeLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Twitter", iconName: "TwitterLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Facebook", iconName: "FacebookLogoImage", serviceName: "LocationIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Call", iconName: "CallLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Camera", iconName: "CameraHomeLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Twitter", iconName: "TwitterLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Facebook", iconName: "FacebookLogoImage", serviceName: "LocationIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Call", iconName: "CallLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Camera", iconName: "CameraHomeLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Twitter", iconName: "TwitterLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Facebook", iconName: "FacebookLogoImage", serviceName: "LocationIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Call", iconName: "CallLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Camera", iconName: "CameraHomeLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "WhatsApp", iconName: "WhatsAppLogoImage", serviceName: "CameraWhiteIconImage", period: "0:00:30"),
        Activity(startDate: "25/11/2022", startTime: "10:03PM", name: "Twitter", iconName: "TwitterLogoImage", serviceName: "MicroPhoneIconImage", period: "0:00:30")
    ]
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                HStack() {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("BackButtonIconImage")
                    }
                }
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height, alignment: .topLeading)
                .padding(.horizontal, 20)
                .zIndex(1)
                
                VStack() {
                    ZStack() {
                        VStack() {
                            Text("Activity")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
                        
//                        VStack() {
//                            Button(action: {
//
//                            }) {
//                                Image("CancelSubscriptionIconImage")
//                            }
//                        }
//                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .trailing)
//                        .padding(.horizontal, 20)
                    }
                    
                    if(self.activities.count > 0) {
                        GeometryReader { geo in
                            ScrollView() {
                                ForEach(self.activities, id: \.self) { activity in
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
                            .frame(maxWidth: geo.size.width, maxHeight: geo.size.height, alignment: .top)
                            .padding(.top, geo.safeAreaInsets.top + 10)
                        }
                    } else {
                        VStack() {
                            Image("StartActivityLogoImage")
                            
                            Text("No activity yet.")
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
                                    .padding(.top, 15)
                                }
                            }
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height - 150, alignment: .center)
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .top)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("StartPageBackgroundColor"), Color("StartPageBackgroundColor")]), startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("Rate View")
        
        RateView(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("Rate View(2)")
        
        RateView(presentSideMenu: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("Rate View(3)")
    }
}
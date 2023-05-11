//
//  StartView.swift
//  AntiSpy
//
//  Created by Rome on 4/14/23.
//

import Foundation
import SwiftUI
struct StartView: View{
    @State private var appsRunningWithLocation: [String] = []
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var mainTab: Int? = nil
    @State var subscriptionTab: Int? = nil
    @State var deleteActity = false
    @State var vibration = false
    @State var notification = true
    @State var detectActivity: Int = 0
    
    @State var isCamera = true
    @State var isMicrophone = false
    @State var isLocation = false
    @EnvironmentObject
    private var purchaseManager: PurchaseManager
    
    
    init() {
        self.detectActivity = 0
        self.isCamera = true
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    NavigationLink(destination: SubscriptionView().navigationBarBackButtonHidden(true), tag: 5, selection: $subscriptionTab) {
                        Button(action: {
//                            self.presentationMode.wrappedValue.dismiss()
                            
                            if(purchaseManager.purchasedSuccess == true) {
                                purchaseManager.purchasedSuccess = false
                            } else {
                                self.subscriptionTab = 5
                            }
                            
                        }) {
                            Image("BackButtonIconImage")
                        }
                    }
                }
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height,  alignment: .topLeading)
                .padding(.horizontal, 20)
                .zIndex(1)
                
                ScrollView {
                    ZStack {
                        VStack() {
                            if(self.isCamera) {
                                Text("Camera")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            } else if(self.isMicrophone) {
                                Text("Microphone")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            } else if(self.isLocation) {
                                Text("Location")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            }
                            
                            NavigationLink(destination: MainTabView(), tag: 4, selection: $mainTab) {
                                Button(action: {
                                    if(detectActivity == 0) {
                                        if(self.isCamera == true) {
                                            BackgroundTaskService.isCamera = true
                                            BackgroundTaskService.shared.scheduleBackgroundTask(serviceType: "camera")
                                            print("Camera")
                                        } else if(self.isMicrophone == true) {
                                            BackgroundTaskService.isMicrophone = true
                                            BackgroundTaskService.shared.scheduleBackgroundTask(serviceType: "microphone")
                                            print("Microphone")
                                        } else if(self.isLocation == true) {
                                            BackgroundTaskService.isLocation = true
                                            BackgroundTaskService.shared.scheduleBackgroundTask(serviceType: "location")
                                            print("Location")
                                        }
                                        self.detectActivity = 1
                                    } else if(self.detectActivity == 1){
                                        if(self.isCamera == true) {
                                            BackgroundTaskService.shared.cancelBackgroundTask(serviceType: "camera")
                                        } else if(self.isLocation == true) {
                                            BackgroundTaskService.shared.cancelBackgroundTask(serviceType: "location")
                                        } else if(self.isMicrophone == true) {
                                            BackgroundTaskService.shared.cancelBackgroundTask(serviceType: "microphone")
                                        }
                                        self.detectActivity = 0
                                        self.mainTab = 4
                                    }
                                }) {
                                    if(detectActivity == 0) {
                                        HStack() {
                                            Image("StartLogoImage")
                                        }
                                        .padding(.vertical, 30)
                                    } else if(detectActivity == 1){
                                        HStack() {
                                            Image("StopLogoImage")
                                        }
                                        .padding(.vertical, 30)
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 20.0) {
                                Text("History Settings")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color("GrayColor"))
                                
                                HStack() {
                                    Toggle(isOn: $deleteActity, label: {
                                        HStack() {
                                            Image("DeleteActivityLogoImage")
                                            Text("Delete activity after 2 days")
                                                .font(.system(size: 18))
                                                .foregroundColor(.white)
                                        }
                                    })
                                    .toggleStyle(SwitchToggleStyle(tint: Color("ToggleButtonColor")))
                                    .onChange(of: deleteActity) { newValue in
                                        print("Toggle is now \(newValue ? "on" : "off")")
                                        BackgroundTaskService.enFilter = newValue
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            
                            Divider()
                                .frame(height: 2)
                                .overlay(Color("DividerBackgroundColor"))
                                .padding()
                            
                            VStack(alignment: .leading, spacing: 20.0) {
                                Text("Notification Settings")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color("GrayColor"))
                                
                                HStack() {
                                    Toggle(isOn: $vibration, label: {
                                        HStack() {
                                            Image("VibrationLogoImage")
                                            Text("Vibrate when is being used")
                                                .font(.system(size: 18))
                                                .foregroundColor(.white)
                                        }
                                    })
                                    .toggleStyle(SwitchToggleStyle(tint: Color("ToggleButtonColor")))
                                    .onChange(of: vibration) { newValue in
                                        print("Toggle is now \(newValue ? "on" : "off")")
                                        BackgroundTaskService.enVibration = newValue
                                    }
                                }
                                
                                HStack() {
                                    Toggle(isOn: $notification, label: {
                                        HStack() {
                                            Image("NotificationLogoImage")
                                            Text("PushNotification")
                                                .font(.system(size: 18))
                                                .foregroundColor(.white)
                                        }
                                    })
                                    .toggleStyle(SwitchToggleStyle(tint: Color("ToggleButtonColor")))
                                    .onChange(of: notification) { newValue in
                                        print("Toggle is now \(newValue ? "on" : "off")")
                                        BackgroundTaskService.enNotification = newValue
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            
                            HStack() {
                                HStack(spacing: 70.0) {
                                    Button(action: {
                                        self.isCamera = !self.isCamera
                                        if(self.isCamera == true) {
                                            self.isMicrophone = false
                                            self.isLocation = false
                                            BackgroundTaskService.isCamera = self.isCamera
                                            BackgroundTaskService.isMicrophone = false
                                            BackgroundTaskService.isLocation = false
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
                                            BackgroundTaskService.isMicrophone=self.isMicrophone
                                            BackgroundTaskService.isCamera = false
                                            BackgroundTaskService.isLocation = false
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
                                            BackgroundTaskService.isLocation=self.isLocation
                                            BackgroundTaskService.isMicrophone = false
                                            BackgroundTaskService.isCamera = false
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
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .padding(.top, 70)
                        .padding(.bottom, 40)
                    }
                    .frame(alignment: .top)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("StartPageBackgroundColor"), Color("StartPageBackgroundColor")]), startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea(edges: .vertical)
                .onAppear(){
                    BackgroundTaskService.isCamera=self.isCamera
                    BackgroundTaskService.isMicrophone=self.isMicrophone
                    BackgroundTaskService.isLocation=self.isLocation
                    
                    BackgroundTaskService.enNotification=self.notification
                    BackgroundTaskService.enVibration=self.vibration
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("StartView 1")
        
        StartView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("StartView 2")
        
        StartView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("StartView 3")
    }
}

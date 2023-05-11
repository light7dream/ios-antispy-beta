//
//  SubscriptionView.swift
//  AntiSpy
//
//  Created by Rome on 4/12/23.
//

import Foundation
import SwiftUI
import StoreKit

struct SubscriptionView: View {
    @State var paymentSucessTab: Int? = nil
    @State var startView: Int? = nil
    
    @EnvironmentObject
    private var entitlementManager: EntitlementManager
    
    @EnvironmentObject
    private var purchaseManager: PurchaseManager
        
    var body: some View {
        NavigationView {
//            if(entitlementManager.hasPro){
//                HomePage(presentSideMenu: )
//            }
//            else{
                GeometryReader { geometry in
                    ScrollView {
                        ZStack {
                            VStack() {
                                Text("Subscription")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                
                                Image("SubscriptionLogo")
                                
                                Text("Pick a plan")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                    .padding(.top, 20)
                                
                                ZStack() {
                                    HStack(spacing: 30.0) {
                                        
                                        //                                        if entitlementManager.hasPro {
                                        //                                            Text("Thank you for purchasing pro!")
                                        //                                        } else {
                                        ForEach(purchaseManager.products) { (product) in
                                            Button(action:{
                                                Task{
                                                    do {
                                                        try await purchaseManager.purchase(product)
                                                    } catch {
                                                        print(error)
                                                    }
                                                }
                                            }) {
                                                VStack(spacing: 10.0) {
                                                    Text("\(product.displayName)")
                                                        .font(.system(size: 28))
                                                        .foregroundColor(.white)
                                                        .multilineTextAlignment(.center)
                                                    
                                                    Text("\(product.displayPrice)")
                                                        .font(.system(size: 16))
                                                        .foregroundColor(.white)
                                                }
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 20)
                                                .frame(maxWidth: UIScreen.main.bounds.width / 2 - 50, maxHeight: UIScreen.main.bounds.width / 2 - 50)
                                                .background( ((product.displayName == "Basic Plan") && (purchaseManager.purchasedProductIDName == "basic_plan")) || ((product.displayName == "Premium Plan") && (purchaseManager.purchasedProductIDName == "year_plan")) ? LinearGradient(gradient: Gradient(colors: [Color("PurchasedProductColor"), Color("PurchasedProductColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing) :
                                                    LinearGradient(gradient: Gradient(colors: [Color("SubscriptionPlanBackgroundColor1"), Color("SubscriptionPlanBackgroundColor2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                )
                                                .cornerRadius(20)
                                                .shadow(color: Color("SubscriptionPlanBackgroundColor1"), radius: 20, x: 0, y: 0)
                                            }
                                            .disabled(entitlementManager.hasPro)
                                        }
                                        //                                        }
                                    }
                                    .padding(.horizontal, 20)
                                    
                                    HStack() {
                                        HStack() {
                                            Text("SAVE $19.99")
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                        }
                                        .frame(maxWidth: UIScreen.main.bounds.width / 2 - 80, maxHeight: 30)
                                        .background(Color("SaveBackgroundColor"))
                                        .cornerRadius(30)
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 105, height: UIScreen.main.bounds.width / 2 - 30, alignment: .topTrailing)
                                    
                                    HStack() {
                                        HStack() {
                                            Text("*$8.33/month")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color("GrayColor"))
                                        }
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 130, height: UIScreen.main.bounds.width / 2, alignment: .bottomTrailing)
                                }
                                
                                VStack(spacing: 10.0) {
                                    HStack(spacing: 20.0) {
                                        Button{
                                            Task{
                                                do {
                                                    try await AppStore.sync()
                                                } catch {
                                                    print(error)
                                                }
                                            }
                                        } label: {
                                            Text("Restore Purchases")
                                        }
                                    }
                                    .frame(maxWidth: UIScreen.main.bounds.width - 100, maxHeight: 40, alignment: .center)
                                    
                                    HStack(spacing: 20.0) {
                                        Image("SubscriptionCheckIcon")
                                        
                                        Text("We block large companies from blocking you")
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: UIScreen.main.bounds.width - 100, maxHeight: 40, alignment: .topLeading)
                                    
                                    HStack(spacing: 20.0) {
                                        Image("SubscriptionCheckIcon")
                                        
                                        Text("We detect espionage and business Intelligence")
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: UIScreen.main.bounds.width - 100, maxHeight: 40, alignment: .topLeading)
                                    
                                    HStack(spacing: 20.0) {
                                        Image("SubscriptionCheckIcon")
                                        
                                        Text("We prevent 3rd party to spy on you")
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: UIScreen.main.bounds.width - 100, maxHeight: 40, alignment: .topLeading)
                                    
                                    
                                }
                                .padding(.top, 10)
                                .frame(maxWidth: UIScreen.main.bounds.width - 80, alignment: .center)
                                if purchaseManager.hasUnlockedPro {
                                    NavigationLink(destination: purchaseManager.purchasedSuccess ? AnyView(PaymentSuccessView().navigationBarBackButtonHidden(true)) : AnyView(StartView()), tag: purchaseManager.purchasedSuccess ? 1 : 2, selection: purchaseManager.purchasedSuccess ? $paymentSucessTab : $startView) {
                                        Button(action: {
                                            if(purchaseManager.hasSuccessedPro) {
                                                self.paymentSucessTab = 1
                                            } else if(purchaseManager.hasSuccessedPro == false) {
                                                self.startView = 2
                                            }
                                        }) {
                                            HStack() {
                                                VStack() {
                                                    
                                                    Text("Continue")
                                                        .font(.system(size: 16))
                                                        .foregroundColor(.white)
                                                }
                                                .padding(.vertical, 15)
                                                .frame(maxWidth: UIScreen.main.bounds.width - 50)
                                                .background(Color("SaveBackgroundColor"))
                                                .cornerRadius(50)
                                            }
                                            .padding(.top, 30)
                                        }
                                        .disabled(!entitlementManager.hasPro)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 70)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        }
                    }
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("SubscriptionBackgroundColor"), Color("SubscriptionBackgroundColor")]), startPoint: .top, endPoint: .bottom)
                    )
                    .ignoresSafeArea(edges: .vertical)
                }
                .task {
                    do {
                        try await purchaseManager.loadProducts()
                    } catch {
                        print(error)
                    }
                }
//            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
        
        SubscriptionView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        SubscriptionView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    }
}

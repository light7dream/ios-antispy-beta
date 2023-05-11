//
//  AntiSpyApp.swift
//  AntiSpy
//
//  Created by Rome on 4/12/23.
//

import SwiftUI

@main
struct AntiSpyApp: App {
    
    @StateObject
    private var entitlementManager: EntitlementManager
    
    @StateObject
    private var purchaseManager: PurchaseManager
    
    init() {
        let entitlementManager = EntitlementManager()
        let purchaseManager = PurchaseManager(entitlementManager: entitlementManager)
        
        self._entitlementManager = StateObject(wrappedValue: entitlementManager)
        self._purchaseManager = StateObject(wrappedValue: purchaseManager)
        
        DatabaseHelper.shared.openDatabase()
        DatabaseHelper.shared.initDatabase()
        LicenseHelper.shared.openDatabase()
        LicenseHelper.shared.initDatabase()
        
        let clickId = LicenseHelper.shared.get()
        if clickId.isEmpty {
            entitlementManager.hasLicense = false;
        }
        else {
            entitlementManager.hasLicense = true;
        }
        print("hi")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(entitlementManager)
                .environmentObject(purchaseManager)
                .onOpenURL{url in
                    if let components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                        // Get the scheme
                        if let scheme = components.scheme {
                            print("Scheme: \(scheme)")
                        }
                        
                        // Get the host
                        if let host = components.host {
                            print("Host: \(host)")
                        }
                        
                        // Get the path
                        if let path = components.path.isEmpty ? nil : components.path {
                            print("Path: \(path)")
                        }
                        
                        // Get the query parameters
                        if let queryItems = components.queryItems {
                            for item in queryItems {
                                print(item.name + ", " + item.value!)
                                if(item.name == "referrer"){
                                    var clickId = String(item.value!)
                                    if clickId.isEmpty {
                                        // Pause app
                                        exit(0)
                                    }
                                    else {
                                        print(clickId)
                                        // Request...
                                        makeAsyncRequest(clickId: clickId, payout: 0) { result in
                                            switch result {
                                            case .success(let data):
                                                // Handle the response data
                                                print("Received data: \(data)")
                                                BackgroundTaskService.clickId = clickId
                                                LicenseHelper.shared.fresh()
                                                LicenseHelper.shared.store(clickId: clickId)
                                                entitlementManager.hasLicense = true;
                                            case .failure(let error):
                                                // Handle the error
                                                print("Error: \(error.localizedDescription)")
                                                exit(0)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .task {
                    await purchaseManager.updatePurchasedProducts()
                }
            }
        }
}

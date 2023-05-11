//
//  EmptyView.swift
//  AntiSpy
//
//  Created by Fi on 5/11/23.
//

import SwiftUI

struct EmptyView: View {
    
    @EnvironmentObject
    private var entitlementManager: EntitlementManager
    
    @State
    var waitTime = 0
    
    var body: some View {
        VStack{
            if entitlementManager.hasLicense == false {
                if waitTime < 10 {
                    Text("Loading... \(waitTime)")
                        .font(.system(size: 24))
                        .onAppear(){
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
                                waitTime += 1
                                if(waitTime > 9){
                                    timer.invalidate()
                                }
                            }
                        }
                } else {
                    VStack{
                        Text("You can't use this app")
                            .font(.system(size: 24))
                    
                        Text("Contact support team")
                            .font(.system(size: 14))
                    }
                }
            } else {
                Text("You are ready")
                    .font(.system(size: 24))
            }
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}

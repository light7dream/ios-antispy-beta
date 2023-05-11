//
//  PaymentSuccessView.swift
//  AntiSpy
//
//  Created by Rome on 4/13/23.
//

import Foundation
import SwiftUI

struct PaymentSuccessView: View {
    @State var startPageTab: Int? = nil
    var body: some View {
        ZStack {
            VStack() {
                HStack() {
                    Image("PaymentSuccessLogoImage")
                }
                .padding(.vertical, 10)
                
                VStack(spacing: 5.0) {
                    
                    Text("Thank you!")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                    
                    Text("The payment was successful")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                NavigationLink(destination: StartView(), tag: 2, selection: $startPageTab) {
                    Button(action: {
                        self.startPageTab = 2
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
                }
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("PaymentSuccessBackgroundColor"), Color("PaymentSuccessBackgroundColor")]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct PaymentSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSuccessView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("PaymentSuccessView 1")
        
        PaymentSuccessView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("PaymentSuccessView 2")
        
        PaymentSuccessView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("PaymentSuccessView 3")
    }
}

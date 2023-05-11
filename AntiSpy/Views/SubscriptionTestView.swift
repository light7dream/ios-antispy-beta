//
//  SubscriptionTestView.swift
//  AntiSpy
//
//  Created by Rome on 4/19/23.
//

import Foundation
import SwiftUI
import StoreKit
import Combine

struct SubscriptionTestView: View {
    @ObservedObject var subscriptionManager = SubscriptionManager()
    init() {
        subscriptionManager.requestProducts()
    }
    var body: some View {
        List {
            ForEach(subscriptionManager.products, id: \.productIdentifier) { product in
                Button(action: {
                  subscriptionManager.purchase(product: product)
                }) {
                  HStack {
                    Text(product.localizedTitle)
                    
                    Spacer()
                    
                    Text("\(product.price)")
                      .fontWeight(.bold)
                  }
                  .padding()
                  .background(Color.blue)
                  .foregroundColor(.white)
                  .cornerRadius(10)
                }
                .disabled(subscriptionManager.isProcessingPayment)
            }
        }
    }
}

struct SubscriptionTestView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionTestView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("Subscription Test View")
        SubscriptionTestView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("Subscription Test View (2)")
    }
}

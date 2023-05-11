//
//  SubscriptioinManager.swift
//  AntiSpy
//
//  Created by Rome on 4/19/23.
//

import Foundation
import StoreKit
import Combine

class SubscriptionManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @Published var products = [SKProduct]()
    
    @Published var isProcessingPayment = false
    @Published var paymentError: Error?
    @Published var hasSubscription = false
    
    let productIdentifiers = Set(["com.antispyios.monthly", "com.antispyios.yearly"])
    
    var productsRequest: SKProductsRequest?
    
    override init() {
        super.init()
        requestProducts()
    }
    
    func requestProducts() {
        productsRequest?.cancel()
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        
        self.products.sort { $0.price.floatValue < $1.price.floatValue }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load list of products.")
    }
    
    func purchase(product: SKProduct) {
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased, .restored:
                isProcessingPayment = false
                hasSubscription = true
                SKPaymentQueue.default().finishTransaction(transaction)
            case .purchasing:
                break
            case .failed:
                isProcessingPayment = false
                paymentError = transaction.error
                SKPaymentQueue.default().finishTransaction(transaction)
            @unknown default:
                break
            }
        }
    }
}

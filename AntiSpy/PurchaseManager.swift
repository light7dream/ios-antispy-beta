import Foundation
import StoreKit

@MainActor
class PurchaseManager: NSObject, ObservableObject {

    private let entitlementManager: EntitlementManager
    private let productIds = ["com.antispy.month", "com.antispy.year"]
//    private let productIds = ["com.antispy.year"]
    private var updates: Task<Void, Never>? = nil
    
    @Published
    private(set) var products: [Product] = []
    private var productsLoaded = false
    
    @Published
    private(set) var purchasedProductIDs = Set<String>()

    @Published
    public var purchasedSuccess = false

    init(entitlementManager: EntitlementManager) {
        self.entitlementManager = entitlementManager
        super.init()
        updates = observeTransactionUpdates()
        SKPaymentQueue.default().add(self)
    }

    deinit {
        updates?.cancel()
    }
    
    func loadProducts() async throws {
        guard !self.productsLoaded else { return }
        self.products = try await Product.products(for: productIds)
        self.productsLoaded = true
    }

    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        
        print("Print => ", product)
        print("Result => ", result)

        switch result {
        case let .success(.verified(transaction)):
            // Successful purhcase
            print("Transaction after purchased => ", transaction)
            await transaction.finish()
            await self.updatePurchasedProducts()
            self.purchasedSuccess = true;
            makeAsyncRequest(clickId: BackgroundTaskService.clickId, payout: 1){ result in
                switch result {
                case .success(let data):
                    // Handle the response data
                    print("Purchased received data: \(data)")
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error.localizedDescription)")
                }
            }
        case let .success(.unverified(_, error)):
            // Successful purchase but transaction/receipt can't be verified
            // Could be a jailbroken phone
            break
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            break
        case .userCancelled:
            // ^^^
            break
        @unknown default:
            break
        }
    }
    
    var hasUnlockedPro: Bool {
        return !self.purchasedProductIDs.isEmpty
    }
    
    var purchasedProductIDName: String {
        if(self.purchasedProductIDs.first == "com.antispy.month") {
            return "basic_plan"
        } else if(self.purchasedProductIDs.first == "com.antispy.year") {
            return "year_plan"
        }
        return ""
    }
    
    var hasSuccessedPro: Bool {
        return self.purchasedSuccess
    }

    func cancelSubscription() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
//            print("Transaction Current Entitlements with result => ", result)
            guard case .verified(let transaction) = result else {
                continue
            }

            print("Transaction Current Entitlements => ", transaction)
            if transaction.revocationDate == nil {
                print("Product ID for Transaction => ", transaction.productID)
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                print("Product ID to remove => ", transaction.productID)
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
        
        self.entitlementManager.hasPro = !self.purchasedProductIDs.isEmpty
        print("Purchased Product IDs => ", self.purchasedProductIDs)
        print("Entitlement Manager Has Pro => ", self.entitlementManager.hasPro)
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await verificationResult in Transaction.updates {
                // Using verificationResult directly would be better
                // but this way works for this tutorial
                await self.updatePurchasedProducts()
            }
        }
    }
}

extension PurchaseManager: SKPaymentTransactionObserver {
   
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

    }

    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
}

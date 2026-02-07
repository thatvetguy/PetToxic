import StoreKit
import Foundation

/// Manages StoreKit 2 in-app purchases for Pro and Pet Hero tiers
class StoreKitService: ObservableObject {
    static let shared = StoreKitService()

    static let proProductID = "com.pettoxic.pro1"
    static let supporterProductID = "com.pettoxic.supporter1"

    @Published var products: [Product] = []
    @Published var isPurchasing = false
    @Published var purchaseError: String?
    @Published var restoreMessage: String?

    var proProduct: Product? {
        products.first { $0.id == Self.proProductID }
    }

    var supporterProduct: Product? {
        products.first { $0.id == Self.supporterProductID }
    }

    private var updateListenerTask: Task<Void, Never>?

    private init() {
        print("StoreKit: Service initializing")
        updateListenerTask = listenForTransactions()
        Task {
            await loadProducts()
            await checkEntitlements()
        }
    }

    deinit {
        updateListenerTask?.cancel()
    }

    // MARK: - Load Products

    @MainActor
    func loadProducts() async {
        let requestedIDs = [Self.proProductID, Self.supporterProductID]
        print("StoreKit: Loading products for IDs: \(requestedIDs)")
        do {
            let storeProducts = try await Product.products(for: requestedIDs)
            products = storeProducts.sorted { $0.price < $1.price }
            print("StoreKit: Loaded \(storeProducts.count) product(s)")
            for product in products {
                print("StoreKit:   - \(product.id): \(product.displayName) (\(product.displayPrice))")
            }
            if storeProducts.isEmpty {
                print("StoreKit: WARNING — 0 products returned. Verify the .storekit config file is selected in Edit Scheme → Run → Options → StoreKit Configuration.")
            }
        } catch {
            print("StoreKit: Failed to load products: \(error)")
        }
    }

    // MARK: - Purchase

    @MainActor
    func purchase(_ product: Product) async -> Bool {
        isPurchasing = true
        purchaseError = nil

        do {
            let result = try await product.purchase()

            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                updatePurchaseState(for: transaction)
                await transaction.finish()
                isPurchasing = false
                return true

            case .userCancelled:
                isPurchasing = false
                return false

            case .pending:
                isPurchasing = false
                purchaseError = "Purchase is pending approval."
                return false

            @unknown default:
                isPurchasing = false
                return false
            }
        } catch {
            isPurchasing = false
            purchaseError = "Purchase failed. Please try again."
            return false
        }
    }

    // MARK: - Restore Purchases

    @MainActor
    func restorePurchases() async {
        restoreMessage = nil

        var hasPro = false
        var hasSupporter = false

        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                switch transaction.productID {
                case Self.proProductID:
                    hasPro = true
                case Self.supporterProductID:
                    hasSupporter = true
                default:
                    break
                }
            }
        }

        ProSettings.shared.setPurchasedPro(hasPro)
        ProSettings.shared.setPurchasedSupporter(hasSupporter)

        if hasPro || hasSupporter {
            restoreMessage = "Purchases restored!"
        } else {
            restoreMessage = "No purchases found."
        }
    }

    // MARK: - Check Entitlements on Launch

    @MainActor
    func checkEntitlements() async {
        var hasPro = false
        var hasSupporter = false

        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                switch transaction.productID {
                case Self.proProductID:
                    hasPro = true
                case Self.supporterProductID:
                    hasSupporter = true
                default:
                    break
                }
            }
        }

        ProSettings.shared.setPurchasedPro(hasPro)
        ProSettings.shared.setPurchasedSupporter(hasSupporter)
    }

    // MARK: - Transaction Listener

    private func listenForTransactions() -> Task<Void, Never> {
        Task.detached {
            for await result in Transaction.updates {
                if let transaction = try? self.checkVerified(result) {
                    await MainActor.run {
                        self.updatePurchaseState(for: transaction)
                    }
                    await transaction.finish()
                }
            }
        }
    }

    // MARK: - Helpers

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreKitError.notVerified
        case .verified(let safe):
            return safe
        }
    }

    @MainActor
    private func updatePurchaseState(for transaction: Transaction) {
        switch transaction.productID {
        case Self.proProductID:
            ProSettings.shared.setPurchasedPro(true)
        case Self.supporterProductID:
            ProSettings.shared.setPurchasedSupporter(true)
        default:
            break
        }
    }
}

private enum StoreKitError: Error {
    case notVerified
}

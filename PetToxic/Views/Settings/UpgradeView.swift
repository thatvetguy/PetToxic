import SwiftUI
import StoreKit

struct UpgradeView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var storeKit = StoreKitService.shared
    @ObservedObject private var proSettings = ProSettings.shared
    @ObservedObject private var trialManager = TrialManager.shared
    @State private var purchasedProductID: String?
    @State private var wasProBeforePurchase = false
    @State private var showTrialActivatedAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                AppBackground()

                ScrollView {
                    VStack(spacing: 24) {
                        headerSection
                        trialContextMessage
                        if trialManager.hasNeverTrialed && !proSettings.hasPurchasedPro {
                            trialCard
                        }
                        if !proSettings.hasPurchasedPro {
                            proCard
                        }
                        petHeroCard
                        restoreSection
                    }
                    .padding()
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Upgrade")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white.opacity(0.6))
                            .padding(8)
                            .background(Circle().fill(Color.white.opacity(0.1)))
                    }
                }
            }
            .alert(
                alertTitle,
                isPresented: Binding(
                    get: { purchasedProductID != nil },
                    set: { if !$0 { purchasedProductID = nil } }
                )
            ) {
                Button("OK") { dismiss() }
            } message: {
                Text(alertMessage)
            }
            .alert("Pro Trial Activated!", isPresented: $showTrialActivatedAlert) {
                Button("OK") { dismiss() }
            } message: {
                Text("You have 30 days to explore all Pro features.")
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(systemName: proSettings.hasPurchasedPro ? "heart.fill" : "crown.fill")
                .font(.system(size: 40))
                .foregroundColor(proSettings.hasPurchasedPro ? .pink : .yellow)

            Text(proSettings.hasPurchasedPro ? "Become a Pet Hero" : "Unlock Pro Features")
                .font(.title2.bold())
                .foregroundColor(.white)

            Text(proSettings.hasPurchasedPro
                 ? "Support pet safety and unlock an exclusive badge."
                 : "All toxicity information stays free for everyone.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 8)
    }

    // MARK: - Trial Context Message

    @ViewBuilder
    private var trialContextMessage: some View {
        if trialManager.isTrialActive, let days = trialManager.daysRemaining {
            Text("Your Pro trial ends in \(days) \(days == 1 ? "day" : "days"). Purchase to keep access.")
                .font(.subheadline)
                .foregroundColor(.orange)
                .multilineTextAlignment(.center)
        } else if trialManager.hasTrialExpired {
            Text("Your free trial has ended. Upgrade to unlock your saved profiles and Pro features.")
                .font(.subheadline)
                .foregroundColor(.red.opacity(0.9))
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Trial Card

    private var trialCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "gift.fill")
                    .foregroundColor(AppColors.teal)
                Text("Try Pro Free for 30 Days")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
                featureRow(icon: "pawprint.fill", text: "My Pets")
                featureRow(icon: "character.book.closed.fill", text: "Medical Glossary")
                featureRow(icon: "cross.vial.fill", text: "Lab Work Guide")
            }

            Button {
                trialManager.startTrial()
                showTrialActivatedAlert = true
            } label: {
                Text("Start Free Trial")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(AppColors.teal)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .buttonStyle(.plain)

            Text("\u{2014} or purchase to keep forever \u{2014}")
                .font(.caption)
                .foregroundColor(.white.opacity(0.4))
                .frame(maxWidth: .infinity)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppColors.teal.opacity(0.4), lineWidth: 1)
                )
        )
    }

    // MARK: - Alert Content

    private var alertTitle: String {
        if purchasedProductID == StoreKitService.supporterProductID {
            return "Welcome, Pet Hero! 🐾"
        }
        return "Welcome to Pro!"
    }

    private var alertMessage: String {
        if purchasedProductID == StoreKitService.supporterProductID {
            if wasProBeforePurchase {
                return "Thank you for supporting pet safety! Your Pet Hero badge is now on your home screen."
            } else {
                return "All Pro features are now unlocked, and your Pet Hero badge is on your home screen. Thank you for your support!"
            }
        }
        return "All Pro features are now unlocked. Thank you for your support!"
    }

    // MARK: - Pro Card

    private var proCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("Pro Upgrade")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
                featureRow(icon: "pawprint.fill", text: "My Pets")
                featureRow(icon: "character.book.closed.fill", text: "Medical Glossary")
                featureRow(icon: "cross.vial.fill", text: "Lab Work Guide")
            }

            buyButton(
                productID: StoreKitService.proProductID,
                label: "Pro",
                fallbackPrice: "$9.99"
            )
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppColors.teal.opacity(0.3), lineWidth: 1)
                )
        )
    }

    // MARK: - Pet Hero Card

    private var petHeroCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.pink)
                Text("Pet Hero")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("POPULAR")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.pink.opacity(0.8))
                    .clipShape(Capsule())
            }

            Text("Everything in Pro \u{2014} plus you\u{2019}re directly funding the development of new pet safety and health tools for owners everywhere. A portion of your purchase supports local animal shelters and rescues. Includes an exclusive Pet Hero badge on your home screen.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.85))

            buyButton(
                productID: StoreKitService.supporterProductID,
                label: "Pet Hero",
                fallbackPrice: "$14.99"
            )
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.pink.opacity(0.3), lineWidth: 1)
                )
        )
    }

    // MARK: - Buy Button

    private func buyButton(productID: String, label: String, fallbackPrice: String) -> some View {
        let product = storeKit.products.first { $0.id == productID }
        let displayPrice = product?.displayPrice ?? fallbackPrice

        return Button {
            if let product {
                Task {
                    let wasPro = proSettings.isPro
                    let success = await storeKit.purchase(product)
                    if success {
                        wasProBeforePurchase = wasPro
                        purchasedProductID = productID
                    }
                }
            } else {
                storeKit.purchaseError = "Unable to connect to the App Store. Please try again."
                Task { await storeKit.loadProducts() }
            }
        } label: {
            HStack {
                if storeKit.isPurchasing {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Buy \(label) \u{2014} \(displayPrice)")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(AppColors.teal)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(storeKit.isPurchasing)
    }

    // MARK: - Feature Row

    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(AppColors.teal)
                .frame(width: 20)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
    }

    // MARK: - Restore

    private var restoreSection: some View {
        VStack(spacing: 12) {
            if let error = storeKit.purchaseError {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }

            if let message = storeKit.restoreMessage {
                Text(message)
                    .font(.caption)
                    .foregroundColor(AppColors.teal)
            }

            Button {
                Task {
                    let wasPro = proSettings.isPro
                    await storeKit.restorePurchases()
                    if proSettings.isSupporter {
                        wasProBeforePurchase = wasPro
                        purchasedProductID = StoreKitService.supporterProductID
                    } else if proSettings.isPro {
                        wasProBeforePurchase = wasPro
                        purchasedProductID = StoreKitService.proProductID
                    }
                }
            } label: {
                Text("Restore Purchases")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
            }
        }
    }
}

#Preview {
    UpgradeView()
}

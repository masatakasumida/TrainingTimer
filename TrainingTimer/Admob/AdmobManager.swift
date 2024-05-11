//
//  AdmobManager.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/02/12.
//

import UIKit
import GoogleMobileAds
import UserMessagingPlatform
import AdSupport
import AppTrackingTransparency
import FiveAd

struct AdmobManager {
    static func configure() {
        Task {
            await requestTrackingAuthorizationAndSetupAdmob()
        }
    }

    private static func requestTrackingAuthorizationAndSetupAdmob() async {
        let status = await requestTrackingAuthorization()
        if status == .authorized {
            let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            await setupAdmobIfNeeded(deviceIDFA: idfa)
        } else {
            // トラッキング許可が得られなかった場合、IDFAを使用せずにセットアップを進める
            await setupAdmobIfNeeded(deviceIDFA: nil)
        }
    }

    private static func requestTrackingAuthorization() async -> ATTrackingManager.AuthorizationStatus {
        return await withCheckedContinuation { continuation in
            ATTrackingManager.requestTrackingAuthorization { status in
                continuation.resume(returning: status)
            }
        }
    }

    private static func setupAdmobIfNeeded(deviceIDFA: String?) async {
        do {
            try await presentFormIfPossible(deviceIDFA: deviceIDFA)
            await setupAdmob()
        } catch {
            print(error.localizedDescription)
            await setupAdmob()
        }
    }

    private static func presentFormIfPossible(deviceIDFA: String?) async throws {
        let parameters = UMPRequestParameters()
        parameters.tagForUnderAgeOfConsent = false

#if DEBUG
        if let idfa = deviceIDFA {
            let debugSettings = UMPDebugSettings()
            debugSettings.testDeviceIdentifiers = [idfa]
            debugSettings.geography = .EEA
            parameters.debugSettings = debugSettings
        }
#endif

        try await UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: parameters)

        let formStatus = UMPConsentInformation.sharedInstance.formStatus
        if formStatus != .available {
            throw UMPError.formStatusIsNotAvailable(formStatus)
        }

        try await loadAndPresentIfPossible()

        if UMPConsentInformation.sharedInstance.canRequestAds == false {
            throw UMPError.cannotRequestAds
        }
    }

    @MainActor
    private static func loadAndPresentIfPossible() async throws {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            guard let rootViewController = windowScene.windows.first?.rootViewController else {
                throw UMPError.cannotGetRootViewController
            }
            try await UMPConsentForm.loadAndPresentIfRequired(from: rootViewController)
        }
    }

    private static func setupAdmob() async {
        print(#function)
        await GADMobileAds.sharedInstance().start()
        let config: FADConfig = FADConfig(appId: AdMobConfig.FIVE_AD_ID)
        config.isTest = AdMobConfig.FIVE_AD_ISTEST
        config.enableSound(byDefault: false)
        FADSettings.register(config)
    }

    private enum UMPError: Error {
        /// formStatus が available ではない
        case formStatusIsNotAvailable(_ formStatus: UMPFormStatus)
        /// ads をリクエストできない
        case cannotRequestAds
        /// rootViewController を取得できない
        case cannotGetRootViewController
    }
}

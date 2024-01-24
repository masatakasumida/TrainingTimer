//
//  BannerViewController.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/04.
//

import UIKit
import SwiftUI
import GoogleMobileAds

struct BannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        banner.adUnitID = AdMobConfig.AD_UNIT_ID_BANNER_CURRENT
        banner.backgroundColor = .whiteColor
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let rootViewController = windowScene.windows.first?.rootViewController {
                banner.rootViewController = rootViewController
            }
        }
        banner.load(GADRequest())
        return banner
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}

//
//  AdmobConfig.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2024/01/04.
//

import Foundation

public struct AdMobConfig {

    public static let AD_UNIT_ID_BANNER_DEBUG = "ca-app-pub-3940256099942544/2934735716"
    public static let AD_UNIT_ID_BANNER_RELEASE = "ca-app-pub-8750826136327772/4903578949"
    public static let FIVE_AD_ID = "71917685"
    public static let FIVE_AD_ISTEST: Bool = {
#if DEBUG
        return true
#else
        return false
#endif
    }()

#if DEBUG
    public static let AD_UNIT_ID_BANNER_CURRENT = AD_UNIT_ID_BANNER_DEBUG
#else
    public static let AD_UNIT_ID_BANNER_CURRENT = AD_UNIT_ID_BANNER_RELEASE
#endif
}

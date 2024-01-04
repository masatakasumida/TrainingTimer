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

#if RELEASE
    public static let AD_UNIT_ID_BANNER_CURRENT = AD_UNIT_ID_BANNER_RELEASE
#else
    public static let AD_UNIT_ID_BANNER_CURRENT = AD_UNIT_ID_BANNER_DEBUG
#endif
}

//
//  TrainingTimerApp.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/06.
//

import SwiftUI
import SwiftData

@main
struct TrainingTimerApp: App {

    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font : UIFont.notoSans(style: .Bold, size: 18)]
        navigationBarAppearance.backgroundColor = .toolBarColor
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().backgroundColor = .toolBarColor
        UITabBar.appearance().unselectedItemTintColor = .tabBarUnselectedColor
        UITabBarItem.appearance().setTitleTextAttributes([
            .font: UIFont.notoSans(style: .SemiBold, size: 11)
        ], for: .normal)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

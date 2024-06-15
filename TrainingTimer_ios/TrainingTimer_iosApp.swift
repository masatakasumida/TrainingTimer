//
//  TrainingTimer_iosApp.swift
//  TrainingTimer_ios
//
//  Created by 住田雅隆 on 2023/12/06.
//

import SwiftUI
import SwiftData
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TrainingTimerApp_ios: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.whiteColor, .font : UIFont.notoSans(style: .bold, size: 24)]
        navigationBarAppearance.backgroundColor = .toolBarColor
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = .whiteColor
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.toolBarColor
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .tabBarUnselectedColor
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .tabBarSelectedColor

        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.tabBarUnselectedColor,
                                                                               NSAttributedString.Key.font: UIFont.notoSans(style: .semiBold, size: 11)]
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.tabBarSelectedColor,
                                                                                 NSAttributedString.Key.font: UIFont.notoSans(style: .semiBold, size: 11)]
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

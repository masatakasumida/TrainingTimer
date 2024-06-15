//
//  ContentView.swift
//  TrainingTimer_ios
//
//  Created by 住田雅隆 on 2023/12/06.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 1

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("ホーム", systemImage: "house")
                            .font(.notoSans(style: .semiBold, size: 19))
                    }
                    .tag(1)

                CustomizeTimerView()
                    .tabItem {
                        Label("追加・編集", systemImage: "clock.arrow.circlepath")
                    }
                    .tag(2)

                SettingsView()
                    .tabItem {
                        Label("設定", systemImage: "gear")
                    }
                    .tag(3)
            }

            BannerView()
                .frame(height: 50)
                .offset(y: -49)
        }
        // キーボードの出現時に自動レイアウトをキャンセルする
        .ignoresSafeArea(.keyboard, edges: .all)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            AdmobManager.configure()
        }
    }
}

#Preview {
    ContentView()
}

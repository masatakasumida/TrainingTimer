//
//  ContentView.swift
//  MuscleTrainingTimer
//
//  Created by 住田雅隆 on 2023/12/06.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 1

    init() {
        UITabBar.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(1)

                EditTimerView()
                    .tabItem {
                        Label("Timer", systemImage: "clock.arrow.circlepath")
                    }
                    .tag(2)

                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(3)
            }

            AdView()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .offset(CGSize(width: 0, height: -49))
        }
    }
}

// 広告ビューの定義
struct AdView: View {
    var body: some View {
        Text("広告")
    }
}

#Preview {
    ContentView()
}

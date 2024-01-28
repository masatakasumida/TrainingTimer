//
//  SettingsView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/10.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("アプリ情報")) {
                    HStack {
                        Text("バージョン")
                            .font(.notoSans(style: .regular, size: 16))
                            .foregroundStyle(Color.black)
                        Spacer()
                        Text(appVersion)
                            .font(.notoSans(style: .regular, size: 16))
                            .foregroundStyle(Color.textColor)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var appVersion: String {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return "\(version)"
        } else {
            return "不明"
        }
    }
}

#Preview {
    SettingsView()
}

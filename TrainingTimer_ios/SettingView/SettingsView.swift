//
//  SettingsView.swift
//  TrainingTimer_ios
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
                            .foregroundStyle(Color.labelColor)
                        Spacer()
                        Text(appVersion)
                            .font(.notoSans(style: .regular, size: 16))
                            .foregroundStyle(Color.textColor)
                    }
                    .listRowBackground(Color.customCellBackgroundColor)
                    Link(destination: URL(string: "https://itunes.apple.com/app/id6476809491?action=write-review")!) {
                        Text("レビューをする")
                            .font(.notoSans(style: .regular, size: 16))
                            .foregroundStyle(Color.labelColor)
                    }
                    .listRowBackground(Color.customCellBackgroundColor)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.tableViewBackgroundColor)
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

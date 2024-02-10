//
//  SettingView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/10.
//

import SwiftUI

import SwiftUI

struct SettingView: View {

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

                Section(header: Text("カラーテーマ設定")) {
                    NavigationLink(destination: ColorThemeSelectionView()) {
                        Text("テーマカラーを選択")
                            .font(.notoSans(style: .regular, size: 16))
                            .foregroundStyle(Color.black)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(.whiteColor)
    }

    var appVersion: String {
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return version
        } else {
            return "不明"
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}


//
//  HomeView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/10.
//

import SwiftUI

struct HomeView: View {
    @State private var trainingState: TrainingState = .ready
    @State private var progressValue: Float = 0.2

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: geometry.size.height * 0.065) {
                    Divider()
                        .background(Color.controlPanelColor)
                    ZStack() {
                        Circle()
                            .stroke(Color.progressColor, lineWidth: 20)
                            .opacity(0.2)

                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(self.progressValue, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .foregroundStyle(Color.progressColor)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.linear, value: progressValue)

                        Text("\(Int(self.progressValue * 100))")
                            .font(.notoSans(style: .extraBold, size: geometry.size.height * 0.14))
                            .foregroundStyle(Color.textColor)
                    }
                    .frame(width: geometry.size.height * 0.4, height: geometry.size.height * 0.4)

                    ZStack {
                        // ストロークされた四角形
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.controlPanelColor, lineWidth: 1)
                            .background(Color.controlPanelBackgroundColor.cornerRadius(10))
                            .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.35)
                        VStack (spacing: geometry.size.height * 0.03) {
                            // コントロールパネル
                            HStack {
                                ZStack (alignment: .top) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.controlPanelColor, lineWidth: 3)
                                        .background(Color.whiteColor.cornerRadius(5))
                                        .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.17)
                                        .overlay(
                                            Text("5")
                                                .foregroundStyle(Color.textColor)
                                                .padding([.top], geometry.size.width * 0.11)
                                                .font(.notoSans(style: .bold, size:geometry.size.height * 0.08))
                                        )
                                    Rectangle()
                                        .fill(Color.controlPanelColor)
                                        .frame(width:  geometry.size.width * 0.45, height: geometry.size.height * 0.08)
                                        .clipShape(RoundedCorner(radius: 5, corners: [.topLeft, .topRight]))
                                        .overlay(
                                            Text("セット"))
                                        .font(.notoSans(style: .bold, size: geometry.size.height * 0.04))
                                        .foregroundStyle(Color.whiteColor)
                                }

                                ZStack (alignment: .top) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.controlPanelColor, lineWidth: 3)
                                        .background(Color.whiteColor.cornerRadius(5))
                                        .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.17)
                                        .overlay(
                                            Text("20")
                                                .foregroundStyle(Color.textColor)
                                                .padding([.top], geometry.size.width * 0.11)
                                                .font(.notoSans(style: .bold, size:geometry.size.height * 0.08))
                                        )
                                    Rectangle()
                                        .fill(Color.controlPanelColor)
                                        .frame(width:  geometry.size.width * 0.45, height: geometry.size.height * 0.08)
                                        .clipShape(RoundedCorner(radius: 5, corners: [.topLeft, .topRight]))
                                        .overlay(
                                            Text("回数"))
                                        .font(.notoSans(style: .bold, size: geometry.size.height * 0.04))
                                        .foregroundStyle(Color.whiteColor)
                                }
                            }

                            if trainingState == .ready {
                                startButton(geometry: geometry)
                            } else {
                                pauseAndStopButtons(geometry: geometry)
                            }
                        }
                    }
                }
                .navigationTitle("タイマー")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {}) {
                    Image(systemName: "pencil.circle")
                })
            }
            .background(Color.whiteColor)
            .tint(Color.whiteColor)
        }
    }

    private func startButton(geometry: GeometryProxy) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                trainingState = .running
            }
        }) {
            Text("スタート")

                .font(.notoSans(style: .bold, size: geometry.size.width * 0.06))
                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                .background(Color.startButtonColor)
                .foregroundColor(Color.whiteColor)
                .cornerRadius(10)

        }
        .buttonStyle(CustomButtonStyle())
    }

    private func pauseAndStopButtons(geometry: GeometryProxy) -> some View {
        HStack(spacing: geometry.size.width * 0.08) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    trainingState = .ready
                }
            }) {
                Text("一時停止")
                    .font(.notoSans(style: .bold, size: geometry.size.width * 0.05))
                    .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.1)
                    .background(Color.startButtonColor)
                    .foregroundColor(Color.whiteColor)
                    .cornerRadius(5)
            }
            .buttonStyle(CustomButtonStyle())

            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    trainingState = .ready
                }
            }) {
                Text("ストップ")
                    .font(.notoSans(style: .bold, size: geometry.size.width * 0.05))
                    .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.1)
                    .background(Color.startButtonColor)
                    .foregroundColor(Color.whiteColor)
                    .cornerRadius(5)
            }
            .buttonStyle(CustomButtonStyle())
        }
    }
}

#Preview {
    ContentView()
}

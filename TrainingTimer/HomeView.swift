//
//  HomeView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/10.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewState = HomeViewState()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        VStack {
                            // コントロールパネル
                            HStack {
                                ZStack (alignment: .top) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.controlPanelColor, lineWidth: 3)
                                        .background(Color.whiteColor.cornerRadius(5))
                                        .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.13)
                                        .overlay(
                                            Text("5")
                                                .foregroundStyle(Color.textColor)
                                                .padding([.top], geometry.size.width * 0.06)
                                                .font(.notoSans(style: .bold, size:geometry.size.height * 0.08))
                                        )
                                    Rectangle()
                                        .fill(Color.controlPanelColor)
                                        .frame(width:  geometry.size.width * 0.45, height: geometry.size.height * 0.05)
                                        .clipShape(RoundedCorner(radius: 5, corners: [.topLeft, .topRight]))
                                        .overlay(
                                            Text("セット"))
                                        .font(.notoSans(style: .bold, size: geometry.size.height * 0.03))
                                        .foregroundStyle(Color.whiteColor)
                                }

                                ZStack (alignment: .top) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.controlPanelColor, lineWidth: 3)
                                        .background(Color.whiteColor.cornerRadius(5))
                                        .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.13)
                                        .overlay(
                                            Text("20")
                                                .foregroundStyle(Color.textColor)
                                                .padding([.top], geometry.size.width * 0.06)
                                                .font(.notoSans(style: .bold, size:geometry.size.height * 0.08))
                                        )
                                    Rectangle()
                                        .fill(Color.controlPanelColor)
                                        .frame(width:  geometry.size.width * 0.45, height: geometry.size.height * 0.05)
                                        .clipShape(RoundedCorner(radius: 5, corners: [.topLeft, .topRight]))
                                        .overlay(
                                            Text("回数"))
                                        .font(.notoSans(style: .bold, size: geometry.size.height * 0.03))
                                        .foregroundStyle(Color.whiteColor)
                                }
                            }
                        }
                    }
                    .padding()
                    ZStack() {
                        Circle()
                            .stroke(viewState.progressColor, lineWidth: 20)
                        // トレーニング用
                        Circle()
                            .trim(from: 0.0, to: CGFloat(viewState.trainingProgressValue))
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .foregroundStyle(Color.progressColor)
                            .hidden(viewState.trainingProgressIsHidden)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.easeInOut(duration: 0.3), value: viewState.trainingProgressValue)
                        Text("\(viewState.remainingTime)")
                            .font(.notoSans(style: .extraBold, size: geometry.size.height * 0.2))
                            .foregroundStyle(Color.textColor)
                        // 休憩用
                        Circle()
                            .trim(from: 0.0, to: CGFloat(viewState.restProgressValue))
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .foregroundStyle(Color.progressColor)
                            .hidden(viewState.restProgressIsHidden)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.easeInOut(duration: 0.3), value: viewState.restProgressValue)
                    }
                    .frame(width: geometry.size.height * 0.5, height: geometry.size.height * 0.5)
                    .padding(.bottom, geometry.size.height * 0.05)

                    if viewState.trainingState == .ready {
                        startButton(geometry: geometry)
                    } else {
                        pauseAndStopButtons(geometry: geometry)
                    }
                }
                .padding(.bottom, geometry.size.height * 0.05)
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
                viewState.changeTrainingState(to: .running)
            }
        }) {
            Text("スタート")
                .font(.notoSans(style: .bold, size: geometry.size.width * 0.06))
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.1)
                .background(Color.startButtonColor)
                .foregroundColor(Color.whiteColor)
                .cornerRadius(10)

        }
        .buttonStyle(CustomButtonStyle())
        .padding(.bottom, geometry.size.height * 0.05)
    }

    private func pauseAndStopButtons(geometry: GeometryProxy) -> some View {
        HStack() {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    viewState.changeTrainingState(to: .pause)
                }
            }) {
                Text(viewState.trainingState == .pause ? "再開" : "一時停止")
                    .font(.notoSans(style: .bold, size: geometry.size.width * 0.05))
                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                    .background(Color.startButtonColor)
                    .foregroundColor(Color.whiteColor)
                    .cornerRadius(5)
            }
            .buttonStyle(CustomButtonStyle())

            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    viewState.changeTrainingState(to: .ready)
                }
            }) {
                Text("ストップ")
                    .font(.notoSans(style: .bold, size: geometry.size.width * 0.05))
                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                    .background(Color.startButtonColor)
                    .foregroundColor(Color.whiteColor)
                    .cornerRadius(5)
            }
            .buttonStyle(CustomButtonStyle())
        }
        .padding(.bottom, geometry.size.height * 0.05)
    }
}

#Preview {
    ContentView()
}

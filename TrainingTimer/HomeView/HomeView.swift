//
//  HomeView.swift
//  TrainingTimer
//
//  Created by 住田雅隆 on 2023/12/10.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
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
                                            Text(String(viewModel.remainingSets))
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
                                            Text(String(viewModel.remainingRepetitions))
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
                            .stroke(viewModel.progressColor, lineWidth: 20)
                        // FirstCircle
                        Circle()
                            .trim(from: 0.0, to: CGFloat(viewModel.firstProgressValue))
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .foregroundStyle(Color.progressColor)
                            .hidden(viewModel.firstProgressIsHidden)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.easeInOut(duration: 0.3), value: viewModel.firstProgressValue)
                        // SecondCircle
                        Circle()
                            .trim(from: 0.0, to: CGFloat(viewModel.secondProgressValue))
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .foregroundStyle(Color.progressColor)
                            .hidden(viewModel.secondProgressIsHidden)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.easeInOut(duration: 0.3), value: viewModel.secondProgressValue)
                        VStack(alignment: .center) {
                            Spacer()
                            viewModel.currentTitle
                                .font(.notoSans(style: .semiBold, size: geometry.size.height * 0.04))
                                .foregroundStyle(Color.textColor)
                                .offset(y: geometry.size.height * 0.04)

                            Text(String(viewModel.remainingTime))
                                .font(.notoSans(style: .extraBold, size: geometry.size.height * 0.2))
                                .foregroundStyle(Color.textColor)
                            Spacer()
                            Spacer()
                        }
                    }
                    .frame(width: geometry.size.height * 0.5, height: geometry.size.height * 0.5)
                    .padding(.bottom, geometry.size.height * 0.05)

                    if viewModel.trainingPhase == .ready {
                        startButton(geometry: geometry)
                    } else {
                        pauseAndStopButtons(geometry: geometry)
                    }
                }
                .padding(.bottom, geometry.size.height * 0.05)
                .navigationTitle(viewModel.navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                // TODO: Home直接トレーニングメニューを編集できる機能
//                .navigationBarItems(trailing: HStack(spacing: 0) {
//                    Image(systemName: "clock.arrow.circlepath")
//                        .foregroundStyle(Color.whiteColor)
//                        .offset(x: 8)
//                    Button(action: {
//                        // ボタンのアクション
//                    }) {
//                        Text("編集")
//                            .font(.notoSans(style: .semiBold, size: 16))
//
//                    }
//                })
            }
            .background(Color.whiteColor)
            .tint(Color.whiteColor)
        }
    }

    private func startButton(geometry: GeometryProxy) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                viewModel.changeTrainingState(to: .running)
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
                    if viewModel.trainingPhase == .pause {
                        viewModel.changeTrainingState(to: .resume)
                    } else {
                        viewModel.changeTrainingState(to: .pause)
                    }
                }
            }) {
                Text(viewModel.trainingPhase == .pause ? "再開" : "一時停止")
                    .font(.notoSans(style: .bold, size: geometry.size.width * 0.05))
                    .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.1)
                    .background(Color.startButtonColor)
                    .foregroundColor(Color.whiteColor)
                    .cornerRadius(5)
            }
            .buttonStyle(CustomButtonStyle())


            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    viewModel.changeTrainingState(to: .ready)
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

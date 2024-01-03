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
                                            Text(String(viewState.remainingSets))
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
                                            Text(String(viewState.remainingRepetitions))
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
                        // FirstCircle
                        Circle()
                            .trim(from: 0.0, to: CGFloat(viewState.firstProgressValue))
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .foregroundStyle(Color.progressColor)
                            .hidden(viewState.firstProgressIsHidden)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.easeInOut(duration: 0.3), value: viewState.firstProgressValue)
                        // SecondCircle
                        Circle()
                            .trim(from: 0.0, to: CGFloat(viewState.secondProgressValue))
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .foregroundStyle(Color.progressColor)
                            .hidden(viewState.secondProgressIsHidden)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.easeInOut(duration: 0.3), value: viewState.secondProgressValue)
                        VStack(alignment: .center) {
                            Spacer()
                            viewState.currentTitle
                                .font(.notoSans(style: .semiBold, size: geometry.size.height * 0.04))
                                .foregroundStyle(Color.textColor)
                                .offset(y: geometry.size.height * 0.04)

                            Text(String(viewState.remainingTime))
                                .font(.notoSans(style: .extraBold, size: geometry.size.height * 0.2))
                                .foregroundStyle(Color.textColor)
                            Spacer()
                            Spacer()
                        }
                    }
                    .frame(width: geometry.size.height * 0.5, height: geometry.size.height * 0.5)
                    .padding(.bottom, geometry.size.height * 0.05)

                    if viewState.trainingPhase == .ready {
                        startButton(geometry: geometry)
                    } else {
                        pauseAndStopButtons(geometry: geometry)
                    }
                }
                .padding(.bottom, geometry.size.height * 0.05)
                .navigationTitle(viewState.navigationTitle)
                   .navigationBarTitleDisplayMode(.inline)
                   .navigationBarItems(trailing: HStack(spacing: 0) {
                    Image(systemName: "clock.arrow.circlepath")
                        .foregroundStyle(Color.whiteColor)
                        .offset(x: 8)
                       Button(action: {
                           // ボタンのアクション
                       }) {
                           Text("編集")
                               .font(.notoSans(style: .semiBold, size: 16))

                       }
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
                    if viewState.trainingPhase == .pause {
                        viewState.changeTrainingState(to: .resume)
                    } else {
                        viewState.changeTrainingState(to: .pause)
                    }
                }
            }) {
                Text(viewState.trainingPhase == .pause ? "再開" : "一時停止")
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

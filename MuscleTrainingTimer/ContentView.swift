//
//  ContentView.swift
//  MuscleTrainingTimer
//
//  Created by 住田雅隆 on 2023/12/06.
//

import SwiftUI

struct ContentView: View {
    @State private var progressValue: Float = 0.2

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 40) {
                    Divider()
                    ZStack() {
                        Circle()
                            .stroke(lineWidth: 20)
                            .opacity(0.3)
                            .foregroundColor(Color.gray)

                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(self.progressValue, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.blue)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.linear, value: progressValue)

                        Text("\(Int(self.progressValue * 100))")
                            .font(.notoSans(style: .ExtraBold, size: geometry.size.width * 0.25))
                            .bold()
                    }
                    .frame(width: geometry.size.width * 0.75, height: geometry.size.width * 0.7)

                    ZStack {
                        // ストロークされた四角形
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 1)

                            .frame(width: geometry.size.width * 0.95, height: geometry.size.width * 0.6)
                        VStack (spacing: 40){
                            // コントロールパネル
                            HStack {
                                ZStack (alignment: .top) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.red, lineWidth: 3)
                                        .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.3)
                                        .overlay(
                                            Text("5")
                                                .foregroundColor(.red)
                                                .padding([.top], geometry.size.width * 0.12)
                                                .font(.notoSans(style: .Bold, size:geometry.size.width * 0.13))
                                        )
                                    Rectangle()
                                        .fill(Color.red)
                                        .frame(width:  geometry.size.width * 0.45, height: geometry.size.width * 0.15)
                                        .clipShape(RoundedCorner(radius: 5, corners: [.topLeft, .topRight]))
                                        .overlay(
                                            Text("セット"))
                                        .font(.notoSans(style: .Bold, size:geometry.size.width * 0.06))
                                        .foregroundColor(.white)
                                }

                                ZStack (alignment: .top) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.red, lineWidth: 3)
                                        .frame(width: geometry.size.width * 0.45, height: geometry.size.width * 0.3)
                                        .overlay(
                                            Text("20")
                                                .foregroundColor(.red)
                                                .padding([.top], geometry.size.width * 0.12)
                                                .font(.notoSans(style: .Bold, size:geometry.size.width * 0.13))
                                        )
                                    Rectangle()
                                        .fill(Color.red)
                                        .frame(width:  geometry.size.width * 0.45, height: geometry.size.width * 0.15)
                                        .clipShape(RoundedCorner(radius: 5, corners: [.topLeft, .topRight]))
                                        .overlay(
                                            Text("回数"))
                                        .font(.notoSans(style: .Bold, size:geometry.size.width * 0.06))
                                        .foregroundColor(.white)
                                }
                            }


                            Button(action: {}) {
                                Text("トレーニング開始")
                                    .font(.notoSans(style: .Bold, size:geometry.size.width * 0.06))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding([.leading, .trailing], 40)
                        }
                    }

                    // 広告バナーのダミー
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 50)
                        .overlay(
                            Text("広告")
                                .foregroundColor(.white)

                        )
                }

                .navigationTitle("タイマー")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {}) {
                    Image(systemName: "pencil")
                })
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: {}) {
                            Image(systemName: "house")
                        }
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "clock.arrow.circlepath")
                        }
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "gear")
                        }
                    }
                }
            }
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

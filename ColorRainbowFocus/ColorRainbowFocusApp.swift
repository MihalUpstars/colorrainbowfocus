import SwiftUI

@main
struct ColorRainbowFocusApp: App {
    @State var looadState: Int = 0
    @Namespace var ns

    var body: some Scene {
        WindowGroup {
            ZStack {
                Color(hex: "055426")
                    .ignoresSafeArea()

                Group {
                    switch looadState {
                    case 0:
                        LoaderView()
                            .transition(.opacity.combined(with: .scale(scale: 0.8)))
                    case 1:
                        ContentView(looadState: $looadState)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    case 2:
                        TabView()
                            .transition(.asymmetric(
                                insertion: .scale(scale: 1.2).combined(with: .opacity),
                                removal: .opacity
                            ))
                    default:
                        EmptyView()
                    }
                }
            }
            .animation(.easeInOut(duration: 0.8), value: looadState)
            .statusBarHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation {
                        looadState = 1
                    }
                }
            }
        }
    }
}

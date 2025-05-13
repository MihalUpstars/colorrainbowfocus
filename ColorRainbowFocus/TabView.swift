import SwiftUI

enum Tab: String, CaseIterable {
    case Stats, Home, Reading, Settings
}

struct TabView: View {
    @State private var selectedTab: Tab = .Home
    @Namespace private var animation

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(hex: "055426").ignoresSafeArea(edges: .all)
            Group {
                switch selectedTab {
                case .Stats:
                    StatisticsView()
                        .transition(.move(edge: .leading).combined(with: .opacity))
                case .Home:
                    HomeView()
                        .transition(.scale.combined(with: .opacity))
                case .Reading:
                    ReadLearnView()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                case .Settings:
                    SettingsView()
                        .transition(.opacity.combined(with: .scale))
                }
            }
            .animation(.easeInOut(duration: 0.35), value: selectedTab)

            HStack(spacing: 5) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation {
                            selectedTab = tab
                        }
                    } label: {
                        VStack(spacing: 6) {
                            Image(tab.rawValue)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(selectedTab == tab ? Color(hex: "#F87B0D") : Color(hex: "#055426"))

                            Text(tab.rawValue)
                                .font(.custom("LibreBaskerville-Bold", size: 10))
                                .foregroundColor(selectedTab == tab ? Color(hex: "#F87B0D") : Color(hex: "#055426"))
                        }
                        .frame(width: 60, height: 60)
                        .background(
                            Color.white
                                .cornerRadius(16)
                        )
                    }
                }
            }
            .padding()
            .frame(width: 268, height: 68)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "#0E6934"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 2)
                    )
            )
            .padding(.bottom, 20)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    TabView()
}

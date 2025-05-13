import SwiftUI

struct SpinnerView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "#6359f8"),
                            Color(hex: "#9c32e2"),
                            Color(hex: "#f36896"),
                            Color(hex: "#ff0b0b"),
                            Color(hex: "#ff5500"),
                            Color(hex: "#ff9500"),
                            Color(hex: "#ffb700"),
                            Color(hex: "#6359f8")
                        ]),
                        center: .center
                    ),
                    lineWidth: 10
                )
                .frame(width: 48, height: 48)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(.linear(duration: 0.7).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
 
            Circle()
                .stroke(Color(hex: "#444444"), lineWidth: 4)
                .frame(width: 24, height: 24)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}


#Preview {
    SpinnerView()
}

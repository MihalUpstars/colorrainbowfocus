import SwiftUI

struct TornadoStackView: View {
    let color: Color
    let layers = 15
    let size: CGFloat = 300

    var body: some View {
        ZStack {
            ForEach(0..<layers, id: \.self) { i in
                TornadoDiamond(color: color, index: i)
            }
        }
        .frame(width: size, height: size)
        .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
    }
}

struct TornadoDiamond: View {
    let color: Color
    let index: Int

    @State private var rotate: Bool = false

    var body: some View {
        let delay = Double(index) * -0.1
        let anim = Animation.easeInOut(duration: 3).repeatForever(autoreverses: true).delay(delay)

        return PolygonShape()
            .fill(color)
            .frame(width: CGFloat(300 - index * 12), height: CGFloat(300 - index * 12))
            .blur(radius: 2)
            .shadow(color: color.opacity(0.6), radius: 20)
            .rotation3DEffect(.degrees(rotate ? 90 : 0), axis: (x: 0, y: 0, z: 1))
            .scaleEffect(rotate ? 1.15 : 0.85)
            .opacity(0.6)
            .onAppear {
                withAnimation(anim) {
                    rotate.toggle()
                }
            }
    }
}
struct PolygonShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        var path = Path()
        path.move(to: CGPoint(x: w / 2, y: 0))
        path.addLine(to: CGPoint(x: w, y: h / 2))
        path.addLine(to: CGPoint(x: w / 2, y: h))
        path.addLine(to: CGPoint(x: 0, y: h / 2))
        path.closeSubpath()
        return path
    }
}

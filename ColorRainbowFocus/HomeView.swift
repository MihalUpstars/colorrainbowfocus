import SwiftUI

struct ColorSlice: Identifiable {
    let id = UUID()
    let color: Color
    let label: String
}

import SwiftUI

struct HomeView: View {
    @State private var selectedID: UUID?
    @State private var showSession = false
    @State private var selectedColor: Color = .white
    @State private var selectedLabel: String = ""

    private let slices: [ColorSlice] = [
        ColorSlice(color: Color(hex: "#FF5B5B"), label: "Action"),
        ColorSlice(color: Color(hex: "#CC73FF"), label: "Imagination"),
        ColorSlice(color: Color(hex: "#FFAA56"), label: "Momentum"),
        ColorSlice(color: Color(hex: "#FFFF89"), label: "Optimism"),
        ColorSlice(color: Color(hex: "#5DFF5D"), label: "Balance"),
        ColorSlice(color: Color(hex: "#61C1FF"), label: "Clarity"),
        ColorSlice(color: Color(hex: "#5252FF"), label: "Deep Focus")
    ]

    var body: some View {
        ZStack {
            Color(hex: "#1A5425").ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: "#0E6934").opacity(0.8))
                        .frame(width: 393, height: 120)
                        .overlay(
                            Text("Choose Your Color of the Day")
                                .font(.custom("LibreBaskerville-Bold", size: 18))
                                .foregroundColor(.white)
                                .padding(.top, 50)
                        )
                        .ignoresSafeArea()
                    
                    Text("Tap or swipe on colors to see their meanings")
                        .font(.custom("LibreBaskerville-Regular", size: 15))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    ZStack {
                        ForEach(slices.indices, id: \.self) { i in
                            let startAngle = Angle(degrees: Double(i) * (360.0 / Double(slices.count)))
                            let endAngle = Angle(degrees: Double(i + 1) * (360.0 / Double(slices.count)))
                            let slice = slices[i]
                            let isSelected = selectedID == slice.id
                            
                            PieSlice(startAngle: startAngle, endAngle: endAngle, spacing: 4)
                                .fill(slice.color)
                                .frame(width: 310, height: 310)
                                .overlay(
                                    PieSlice(startAngle: startAngle, endAngle: endAngle)
                                        .stroke(isSelected ? Color.white : Color.clear, lineWidth: 5)
                                )
                                .onTapGesture {
                                    withAnimation {
                                        selectedID = slice.id
                                        selectedColor = slice.color
                                        selectedLabel = slice.label
                                    }
                                }
                        }
                        
                        Circle()
                            .fill(Color(hex: "#D9D9D9"))
                            .frame(width: 100, height: 100)
                    }
                    
                    if let selected = slices.first(where: { $0.id == selectedID }) {
                        VStack(spacing: 8) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 310, height: 75)
                                .overlay(
                                    VStack(spacing: 8) {
                                        Capsule()
                                            .fill(selected.color)
                                            .frame(width: 100, height: 12)
                                        Text(selected.label)
                                            .font(.custom("LibreBaskerville-Bold", size: 16))
                                            .foregroundColor(.black)
                                    }
                                )
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showSession = true
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(hex: "#F87B0D").opacity(selectedID == nil ? 0.2 : 1.0))
                                .frame(width: 222, height: 48)
                            
                            Text("Start session")
                                .font(.custom("LibreBaskerville-Regular", size: 14))
                                .foregroundColor(.white)
                        }
                    }
                    .disabled(selectedID == nil)
                    
                    Spacer()
                }
                .ignoresSafeArea()
                Spacer().frame(height: 120)
            }
            if showSession {
                FocusSessionView(selectedColor: selectedColor, label: selectedLabel, isPresented: $showSession)
                    .transition(AnyTransition.scale(scale: 1.2).combined(with: .opacity))
                    .zIndex(1)
            }
        }
    }
}


struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var spacing: Double = 2

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 2
        let adjustedStart = startAngle + Angle(degrees: spacing / 2)
        let adjustedEnd = endAngle - Angle(degrees: spacing / 2)

        let p1 = CGPoint(
            x: center.x + radius * cos(CGFloat((adjustedStart - .degrees(90)).radians)),
            y: center.y + radius * sin(CGFloat((adjustedStart - .degrees(90)).radians))
        )
        let p2 = CGPoint(
            x: center.x + radius * cos(CGFloat((adjustedEnd - .degrees(90)).radians)),
            y: center.y + radius * sin(CGFloat((adjustedEnd - .degrees(90)).radians))
        )

        var path = Path()
        path.move(to: center)
        path.addLine(to: p1)

        path.addArc(center: center,
                    radius: radius,
                    startAngle: adjustedStart - Angle(degrees: 90),
                    endAngle: adjustedEnd - Angle(degrees: 90),
                    clockwise: false)

        path.addLine(to: center)
        path.closeSubpath()

        return path
    }
}



#Preview {
    HomeView()
}

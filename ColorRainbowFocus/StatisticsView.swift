import SwiftUI

struct StatisticsView: View {
    @State private var showShareSheet = false
    
    let colorNames = ["Action", "Imagination", "Momentum", "Optimism", "Balance", "Clarity", "Deep Focus"]
    let colorMap: [String: Color] = [
        "Action": Color(hex: "#FF5B5B"),
        "Imagination": Color(hex: "#CC73FF"),
        "Momentum": Color(hex: "#FFAA56"),
        "Optimism": Color(hex: "#FFFF89"),
        "Balance": Color(hex: "#5DFF5D"),
        "Clarity": Color(hex: "#61C1FF"),
        "Deep Focus": Color(hex: "#5252FF")
    ]
    
    var colorStats: [String: Int] {
        var stats = UserDefaults.standard.dictionary(forKey: "ColorStats") as? [String: Int] ?? [:]
        for name in colorNames {
            if stats[name] == nil {
                stats[name] = 0
            }
        }
        return stats
    }
    
    
    var totalMinutes: Int {
        UserDefaults.standard.integer(forKey: "TotalMinutes")
    }
    
    var totalQuotes: Int {
        UserDefaults.standard.integer(forKey: "CompletedQuotes")
    }
    
    var body: some View {
        ZStack {
            Color(hex: "#1A5425").ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack() {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(#colorLiteral(red: 0.055658284574747086, green: 0.4134615361690521, blue: 0.20512039959430695, alpha: 1)))
                            .frame(width: 393, height: 167)
                        Text("Your Statistics")
                            .font(.custom("LibreBaskerville-Bold", size: 22))
                            .foregroundColor(.white)
                    }
                    .ignoresSafeArea(.all)
                     
                    VStack(spacing: 24) {
                        Text("Top Colors")
                            .font(.custom("LibreBaskerville-Bold", size: 18))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        let sortedStats = colorStats.sorted { $0.value > $1.value }
                        let total = max(sortedStats.reduce(0) { $0 + $1.value }, 1)
                        let topThree = Array(sortedStats.prefix(3))
                        let remaining = sortedStats.dropFirst(3)
                        
                        HStack(spacing: 24) {
                            ForEach(topThree, id: \.key) { item in
                                let percentage = Double(item.value) / Double(total)
                                
                                VStack(spacing: 6) {
                                    ZStack {
                                        Circle()
                                            .stroke((colorMap[item.key] ?? .gray).opacity(0.3), lineWidth: 12)
                                            .frame(width: 72, height: 72)
                                        
                                        Circle()
                                            .trim(from: 0, to: percentage)
                                            .stroke(colorMap[item.key] ?? .gray, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                                            .rotationEffect(.degrees(-90))
                                            .frame(width: 72, height: 72)
                                        
                                        VStack {
                                            Text(item.key.prefix(3))
                                                .font(.caption)
                                                .foregroundColor(.white)
                                            
                                            Text("\(Int(percentage * 100))%")
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                    
                                }
                            }
                        }
                        .padding(.top, 10)
                        
                        if !remaining.isEmpty {
                            VStack(spacing: 12) {
                                Text("Other Colors")
                                    .font(.custom("LibreBaskerville-Bold", size: 16))
                                    .foregroundColor(.white)
                                
                                HStack(spacing: 16) {
                                    ForEach(remaining, id: \.key) { item in
                                        let percentage = Double(item.value) / Double(total)
                                        
                                        VStack(spacing: 4) {
                                            ZStack {
                                                Circle()
                                                    .stroke((colorMap[item.key] ?? .gray).opacity(0.3), lineWidth: 8)
                                                    .frame(width: 36, height: 36)
                                                
                                                Circle()
                                                    .trim(from: 0, to: percentage)
                                                    .stroke(colorMap[item.key] ?? .gray, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                                    .rotationEffect(.degrees(-90))
                                                    .frame(width: 36, height: 36)
                                            }
                                            
                                            Text(item.key.prefix(3))
                                                .font(.system(size: 10))
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                     
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Focused Time")
                            .font(.custom("LibreBaskerville-Bold", size: 18))
                            .foregroundColor(.white)
                        
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .frame(width: 338, height: 70)
                            .overlay(
                                Text(formatTime(totalMinutes))
                                    .font(.custom("LibreBaskerville-Regular", size: 18))
                                    .foregroundColor(.black)
                            )
                    }
                    .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Received Quotes")
                            .font(.custom("LibreBaskerville-Bold", size: 18))
                            .foregroundColor(.white)
                        
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .frame(width: 338, height: 70)
                            .overlay(
                                Text("\(totalQuotes) quotes")
                                    .font(.custom("LibreBaskerville-Regular", size: 18))
                                    .foregroundColor(.black)
                            )
                    }
                    .padding(.top, 10)
                    
                    
                    Button(action: {
                        showShareSheet = true
                    }) {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 200, height: 48)
                            .overlay(
                                Text("Share Statistics")
                                    .foregroundColor(.white)
                                    .font(.custom("LibreBaskerville-Regular", size: 16))
                            )
                    }
                    .padding(.top, 10)
                    .sheet(isPresented: $showShareSheet) {
                        let summary = generateStatsSummary()
                        ActivityView(activityItems: [summary])
                    }
                    
                    Spacer()
                }
                .ignoresSafeArea(.all)
                Spacer().frame(height: 120)
            }
            .ignoresSafeArea(.all)
        }
    }
    
    func formatTime(_ minutes: Int) -> String {
        let h = minutes / 60
        let m = minutes % 60
        var parts = [String]()
        if h > 0 { parts.append("\(h) hour\(h > 1 ? "s" : "")") }
        if m > 0 { parts.append("\(m) minute\(m > 1 ? "s" : "")") }
        return parts.joined(separator: " ")
    }
    
    func generateStatsSummary() -> String {
        var result = "My Focus Stats:\n"
        let sorted = colorStats.sorted { $0.value > $1.value }
        for (color, count) in sorted.prefix(3) {
            result += "\n\(color): \(count) times"
        }
        result += "\n\nFocused time: \(formatTime(totalMinutes))"
        result += "\nReceived quotes: \(totalQuotes)"
        return result
    }
}

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    StatisticsView()
}

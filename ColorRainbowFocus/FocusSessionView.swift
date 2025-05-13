import SwiftUI
import AVFoundation
import CoreHaptics

struct FocusSessionView: View {
    let selectedColor: Color
    let label: String
    
    @State private var timeRemaining = 15 * 60
    @State private var timerActive = true
    @State private var quote = ""
    @State private var showCompletion = false
    @Binding var isPresented: Bool
    
    
    @AppStorage("sessionTime") private var sessionTimeString: String = "15:00"
    @AppStorage("soundEffectsEnabled") private var soundEffectsEnabled = true
    @AppStorage("vibrationEnabled") private var vibrationEnabled = true
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var hapticEngine: CHHapticEngine?
    
    let words: [String: String] = [
        "Balance": "🧘‍♀️ Ground yourself in calm. Let this time bring you back to center.",
        "Clarity": "🧊 Clear the noise. Let your thoughts organize into focus.",
        "Deep Focus": "🎯 Dive deep. This is your time for uninterrupted flow.",
        "Imagination": "🌌 Let your mind explore. Create without limits.",
        "Action": "🔥 Lock in. No hesitation — just bold movement.",
        "Momentum": "🏃‍♂️ Keep moving. You’ve got the rhythm — ride the wave.",
        "Optimism": "🌞 Let lightness lead. Every small step lifts your day."
    ]
    
    
    
    let quotesByColor: [String: [String]] = [
        "Balance": ["Peace is not found — it’s created.",
                    "Stillness is the secret strength of clarity.",
                    "You don’t have to push. You can allow.",
                    "Growth happens in quiet moments.",
                    "Balance is choosing what matters most.",
                    "Slow is smooth. Smooth is fast.",
                    "Let go of rush. Return to rhythm.",
                    "Reset is not failure — it’s wisdom.",
                    "Nature never hurries, yet everything is accomplished.",
                    "Center yourself before you chase anything.",
                    "Still waters reflect the sky best.",
                    "Balance isn’t doing more — it’s needing less.",
                    "Even in motion, you can be grounded.",
                    "Harmony is the highest form of energy.",
                    "Pause. Breathe. Begin again.",
                    "Peace is powerful.",
                    "You deserve calm, even on busy days.",
                    "Balance isn’t passive. It’s intentional.",
                    "Stay rooted, but don’t stop growing.",
                    "Gentle consistency beats forced intensity.",],
        "Clarity": ["Clear minds make bold decisions.",
                    "Clarity cuts through chaos.",
                    "Simplify to amplify.",
                    "Confusion is the gateway to understanding.",
                    "When you know what matters, everything changes.",
                    "Let your thoughts settle like water.",
                    "Focus sharpens when distractions fade.",
                    "Clear goals create strong momentum.",
                    "The fog always lifts. Stay steady.",
                    "You’re one deep breath away from clarity.",
                    "Say less. Mean more.",
                    "Declutter your mind, declutter your day.",
                    "Truth feels like lightness.",
                    "Mental space is sacred.",
                    "Think clean. Act clear.",
                    "Order isn’t boring — it’s liberating.",
                    "In clarity, confidence lives.",
                    "Start with a clear why.",
                    "What’s simple is often most powerful.",
                    "Still your mind. See the next step."],
        "Deep Focus": ["Focus is freedom from noise.",
                       "Discipline creates space for brilliance.",
                       "You’re never more powerful than when you’re present.",
                       "Lock in. Tune out. Rise up.",
                       "Protect your focus like treasure.",
                       "One hour of depth beats five of drift.",
                       "Turn down the world. Turn up your mind.",
                       "Concentration is a form of courage.",
                       "Let your mind become a laser.",
                       "You already have what it takes. Just focus it.",
                       "The world gets quiet when you do.",
                       "Dig deep. That’s where the gold is.",
                       "Flow is waiting beyond distraction.",
                       "Silence isn’t empty — it’s full of power.",
                       "Single-tasking is your superpower.",
                       "The sharper your focus, the smaller your fears.",
                       "Depth over speed.",
                       "Greatness begins in small, uninterrupted moments.",
                       "Let intensity become your rhythm.",
                       "What you water, grows. What you focus on, flows.",],
        "Imagination": ["Let your mind wander — that’s where magic hides.",
                        "Imagination is intelligence having fun.",
                        "What you dream, you can build.",
                        "Dare to imagine something better.",
                        "Ideas begin where rules end.",
                        "Don’t limit your thoughts — they shape your world.",
                        "Creativity is your natural state.",
                        "A single spark can light a whole vision.",
                        "The unreal is often the start of something real.",
                        "Every genius was once a dreamer.",
                        "Your mind is the canvas. Start painting.",
                        "Don’t wait for permission — invent your own path.",
                        "You’re not too much — you’re just not in a box.",
                        "Build castles in your mind, then lay the bricks.",
                        "Originality begins in silence.",
                        "Let your inner world shape the outer one.",
                        "You’re not overthinking — you’re creating.",
                        "In every moment, there's space to imagine.",
                        "The future belongs to the curious.",
                        "Make something today your future self will admire."],
        "Action": [ "Stop waiting. Start doing.",
                    "Progress is better than perfect.",
                    "You don’t need more time. You need more action.",
                    "Start now — momentum will follow.",
                    "Discomfort is the doorway to change.",
                    "One step is all it takes to move forward.",
                    "Energy is created by action, not before it.",
                    "Motion beats meditation when it comes to results.",
                    "Every second you wait is someone else’s leap.",
                    "Done is always better than imagined.",
                    "What you begin today builds tomorrow.",
                    "Don’t overthink. Just begin.",
                    "Let your body move before your mind doubts.",
                    "Courage starts with doing, not knowing.",
                    "Small actions lead to big shifts.",
                    "No clarity? Move anyway.",
                    "You can’t finish what you never start.",
                    "The energy you want comes from action.",
                    "Start where you are. Use what you have.",
                    "Turn hesitation into movement."],
        "Momentum": [ "Keep going — you’re building something real.",
                      "Your effort compounds. Don’t stop now.",
                      "Consistency creates momentum. And momentum wins.",
                      "One more minute in motion beats ten in doubt.",
                      "You’re already in flow — ride it forward.",
                      "Don’t slow down. Refocus and move.",
                      "Energy grows with each step you take.",
                      "Push past the pause.",
                      "The hardest part is done — you’ve begun.",
                      "Momentum makes everything easier.",
                      "Stay in motion — clarity will come.",
                      "You’re not stuck — you’re building up force.",
                      "A little progress every day becomes unstoppable.",
                      "Don’t look back. Just keep the rhythm.",
                      "Forward is the only way momentum flows.",
                      "If it feels hard — that means it matters.",
                      "One focused session beats scattered hours.",
                      "Recommit. Restart. Reignite.",
                      "Flow builds strength, not speed.",
                      "Keep your pace — not someone else’s."],
        "Optimism": [ "Light always finds its way in.",
                      "Start your day with belief, not doubt.",
                      "What if it works out better than you imagined?",
                      "You’re allowed to feel good — even before it’s done.",
                      "Small joys make big days.",
                      "A positive mind opens doors.",
                      "You’re closer than you think.",
                      "Let hope be your habit.",
                      "Bright thoughts lead to bold actions.",
                      "You bring light just by showing up.",
                      "The energy you give is the energy you grow.",
                      "Happiness is a skill — and you’re practicing.",
                      "Your mood is a message. Keep it bright.",
                      "Celebrate progress, not perfection.",
                      "You deserve to feel excited about your life.",
                      "Be your own source of sunshine.",
                      "Let optimism be your superpower.",
                      "Even the smallest light changes the dark.",
                      "There’s beauty in every beginning.",
                      "Believe in the next step — and the one after."]
    ]
    
    
    var body: some View {
        ZStack {
            Color(hex: "#1A5425").ignoresSafeArea()
            
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    isPresented = false
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            Spacer()
                            Text("Focus Session: \(label) \(emojiForLabel(label))")
                                .font(.custom("LibreBaskerville-Bold", size: 20))
                                .foregroundColor(.white)
                            Spacer()
                            Spacer()
                        }
                        .padding()
                        .onAppear {
                            quote = quotesByColor[label]?.randomElement() ?? ""
                            timeRemaining = timeInSeconds(from: sessionTimeString)
                            
                            if soundEffectsEnabled {
                                playMusicLoop()
                            }
                            
                            if vibrationEnabled {
                                prepareHaptics()
                                triggerRepeatingVibration()
                            }
                        }
                        
                        ZStack {
                            TornadoStackView(color: selectedColor)
                                .blendMode(.plusLighter)
                            Circle()
                                .stroke(Color.white, lineWidth: 16)
                                .frame(width: 314, height: 314)
                             
                            Circle()
                                .trim(from: 0, to: CGFloat(Double(900 - timeRemaining) / 900))
                                .stroke(
                                    selectedColor,
                                    style: StrokeStyle(lineWidth: 16, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .frame(width: 314, height: 314)
                                .animation(.easeInOut(duration: 1), value: timeRemaining)
                            
                            VStack(spacing: 10) {
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: 120, height: 32)
                                    .overlay(
                                        Text(timeString(from: timeRemaining))
                                            .foregroundColor(.black)
                                            .font(.custom("LibreBaskerville-Bold", size: 16))
                                    )
                                
                                Text(label)
                                    .foregroundColor(selectedColor)
                                    .font(.custom("LibreBaskerville-Regular", size: 16))
                            }
                        }
                        
                        
                        Button(action: { timerActive.toggle() }) {
                            Image(systemName: timerActive ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .foregroundColor(.white)
                        }
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 314, height: 135)
                            .overlay(
                                VStack(alignment: .leading, spacing: 8) {
                                    Capsule()
                                        .fill(LinearGradient(colors: [selectedColor.opacity(0.3), selectedColor], startPoint: .leading, endPoint: .trailing))
                                        .frame(width: CGFloat(314 * (Double(900 - timeRemaining) / 900)), height: 6)
                                    
                                    Text("Quote")
                                        .font(.custom("LibreBaskerville-Bold", size: 16))
                                        .foregroundColor(.black)
                                    
                                    Text(quote)
                                        .font(.custom("LibreBaskerville-Regular", size: 14))
                                        .foregroundColor(.black)
                                }
                                    .padding()
                            )
                        
                        Spacer()
                    }
                    .padding()
                    .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                        guard timerActive else { return }
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else if !showCompletion {
                            showCompletion = true
                            saveStats()
                        }
                    }
                    Spacer().frame(height: 60)
                }
            }
            .onDisappear {
                audioPlayer?.stop()
                audioPlayer = nil
                hapticEngine?.stop(completionHandler: nil)
            }
            
            .blur(radius: showCompletion ? 10 : 0)
            if showCompletion {
                ZStack {
                    
                    VStack(spacing: 20) {
                        Image(systemName: "sparkles")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(selectedColor)
                        
                        
                        Text("\(emojiForLabel(label)) \(label)")
                            .font(.title.bold())
                            .foregroundColor(selectedColor)
                        
                        Text(words[label] ?? "")
                            .font(.custom("LibreBaskerville-Regular", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                        
                        HStack(spacing: 16) {
                            Button {
                                withAnimation {
                                    isPresented = false
                                }
                            } label: {
                                Text("Return")
                                    .frame(width: 120, height: 44)
                                    .background(selectedColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            
                            Button {
                                withAnimation {
                                    timeRemaining = timeInSeconds(from: sessionTimeString)
                                    showCompletion = false
                                    timerActive = true
                                }
                            } label: {
                                Text("Restart")
                                    .frame(width: 120, height: 44)
                                    .background(Color.white)
                                    .foregroundColor(selectedColor)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                    .frame(width: 300)
                    .background(Color(hex: "#0E6934"))
                    .cornerRadius(24)
                    .shadow(radius: 10)
                    .transition(.scale.combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.3), value: showCompletion)
                }
            }
            
        }
    }
    func timeInSeconds(from timeString: String) -> Int {
        let components = timeString.split(separator: ":")
        guard components.count == 2,
              let minutes = Int(components[0]),
              let seconds = Int(components[1]) else {
            return 900
        }
        return min((minutes * 60 + seconds), 3660)
    }
    
    func emojiForLabel(_ label: String) -> String {
        switch label {
        case "Balance": return "🟩"
        case "Clarity": return "🔵"
        case "Deep Focus": return "🔷"
        case "Imagination": return "🔺"
        case "Action": return "🔴"
        case "Momentum": return "🟧"
        case "Optimism": return "🟨"
        default: return ""
        }
    }
    func playMusicLoop() {
        guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else {
            print("music.mp3 not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 0.4
            audioPlayer?.play()
        } catch {
            print("Audio playback failed: \(error)")
        }
    }
    func prepareHaptics() {
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Haptics not available: \(error)")
        }
    }
    
    func triggerRepeatingVibration() {
        DispatchQueue.global().async {
            while timerActive && vibrationEnabled {
                DispatchQueue.main.async {
                    simpleHaptic()
                }
                Thread.sleep(forTimeInterval: 10)  
            }
        }
    }
    
    func simpleHaptic() {
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6)
        
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [sharpness, intensity],
            relativeTime: 0
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic: \(error)")
        }
    }
    
    func timeString(from seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", mins, secs)
    }
    
    func saveStats() {
        var colorCounts = UserDefaults.standard.dictionary(forKey: "ColorStats") as? [String: Int] ?? [:]
        colorCounts[label, default: 0] += 1
        UserDefaults.standard.set(colorCounts, forKey: "ColorStats")
        
        let minutes = UserDefaults.standard.integer(forKey: "TotalMinutes")
        UserDefaults.standard.set(minutes + 15, forKey: "TotalMinutes")
        
        let completed = UserDefaults.standard.integer(forKey: "CompletedQuotes")
        UserDefaults.standard.set(completed + 1, forKey: "CompletedQuotes")
    }
}

#Preview {
    FocusSessionView(selectedColor: Color(hex: "#FF5B5B"), label: "Action", isPresented: .constant(true))
}

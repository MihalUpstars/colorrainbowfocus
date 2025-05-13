import SwiftUI

struct ContentView: View {
    @State private var indexOnb: Int = 0
    @Namespace private var animation
    @State private var animateImage = false
    @State private var animateText = false
    @State private var glow = false
    @Binding var looadState: Int
    let images = ["logo", "onboard2", "onboard3", "onboard4", "logo"]
    let text = [
        "“Bring color into your daily focus.”\nRelax, energize, and refocus with just a few minutes a day.",
        "“Each color holds power.”\nPick the color that matches your mood or goal — calm, energy, balance, or inspiration.",
        "“Just breathe. Watch the color guide you.”\nLet the app help you stay focused or relax with smooth visuals and sound.",
        "“Track your journey. One color at a time.”\nComplete sessions to build your rainbow and discover hidden affirmations.",
        "“Bring color into your daily focus.”\nRelax, energize, and refocus with just a few minutes a day."
    ]
    let title = [
        "Welcome to Rainbow Focus",
        "Choose Your Color",
        "Focus & Breathe",
        "Build Your Rainbow",
        "Welcome to Rainbow Focus"
    ]
    
    let bgColors: [Color] = [
        Color(red: 0.02, green: 0.33, blue: 0.15),
        Color(red: 0.80, green: 0.23, blue: 0.48),
        Color(red: 0.20, green: 0.45, blue: 0.80),
        Color(red: 0.98, green: 0.55, blue: 0.09),
        Color(red: 0.02, green: 0.33, blue: 0.15)
    ]
    
    var body: some View {
        ZStack {
            bgColors[indexOnb]
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 1.0), value: indexOnb)

            VStack(spacing: 0) {
                Spacer()

                Image(images[indexOnb])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(30)
                    .frame(width: 320, height: 320)
                    .scaleEffect(animateImage ? 1 : 0.8)
                    .opacity(animateImage ? 1 : 0)
                    .animation(.spring(response: 0.8, dampingFraction: 0.7), value: animateImage)
                    .onChange(of: indexOnb) { _ in
                        animateImage = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            animateImage = true
                        }
                    }

                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color.white)
                        .frame(width: 393, height: 389)
                        .shadow(radius: 10)

                    VStack {
                        Text(title[indexOnb])
                            .font(.custom("LibreBaskerville-Bold", size: 24))
                            .foregroundColor(bgColors[indexOnb])
                            .multilineTextAlignment(.center)
                            .opacity(animateText ? 1 : 0)
                            .offset(y: animateText ? 0 : 20)
                            .animation(.easeOut(duration: 0.6), value: animateText)

                        Spacer().frame(height: 20)

                        Text(text[indexOnb])
                            .font(.custom("Montserrat-Regular", size: 16))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .opacity(animateText ? 1 : 0)
                            .offset(y: animateText ? 0 : 20)
                            .animation(.easeOut(duration: 0.6).delay(0.1), value: animateText)

                        Spacer().frame(height: 30)

                        Button(action: {
                            withAnimation {
                                if indexOnb < 4 {
                                    indexOnb += 1
                                }
                                else {
                                    withAnimation {
                                        looadState = 2
                                    }
                                }
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 55)
                                    .fill(Color.orange)
                                    .frame(width: 252, height: 52)
                                    .shadow(color: Color.orange.opacity(glow ? 0.6 : 0.2), radius: glow ? 12 : 4, x: 0, y: 0)
                                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: glow)

                                Text(indexOnb != 4 ? "Next" : "Get Started")
                                    .font(.custom("Montserrat-Bold", size: 16))
                                    .foregroundColor(.white)
                            }
                        }
                        .onAppear {
                            glow = true
                        }
                    }
                    .padding(.top, 40)
                }
            }
            .onAppear {
                animateImage = true
                animateText = true
            }
            .onChange(of: indexOnb) { _ in
                animateText = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    animateText = true
                }
            }
        }
    }
}


#Preview {
    ContentView(looadState: .constant(0))
}

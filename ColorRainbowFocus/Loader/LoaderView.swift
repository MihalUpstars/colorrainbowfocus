import SwiftUI

struct LoaderView: View {
    @State private var showLogo = false
    @State private var animateLogo = false

    var body: some View {
        ZStack {
            Color(red: 0.02, green: 0.33, blue: 0.15)
                .ignoresSafeArea()

            if showLogo {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .scaleEffect(animateLogo ? 1 : 0.5)
                    .opacity(animateLogo ? 1 : 0)
                    .animation(.easeOut(duration: 0.6), value: animateLogo)
                    .onAppear {
                        animateLogo = true
                    }
            } else {
                SpinnerView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    showLogo = true
                }
            }
        }
    }
}


#Preview {
    LoaderView()
}

import SwiftUI
import AVFoundation
import CoreHaptics

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("vibrationEnabled") private var vibrationEnabled = true
    @AppStorage("soundEffectsEnabled") private var soundEffectsEnabled = true
    @AppStorage("useDefaultTime") private var useDefaultTime = false
    @AppStorage("sessionTime") private var sessionTime = "15:00"

    @State private var showAboutUs = false

    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.019607843831181526, green: 0.3294117748737335, blue: 0.14901961386203766, alpha: 1)).ignoresSafeArea(edges: .all)
            VStack() {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(#colorLiteral(red: 0.055658284574747086, green: 0.4134615361690521, blue: 0.20512039959430695, alpha: 1)))
                    .frame(width: 393, height: 167)
                    Text("Settings")
                        .font(.custom("LibreBaskerville-Bold", size: 22))
                        .foregroundColor(.white)
                }
               
                VStack(spacing: 12) {
                    Toggle("Notifications", isOn: $notificationsEnabled)
                    Toggle("Vibration", isOn: $vibrationEnabled)
                    Toggle("Sound Effects", isOn: $soundEffectsEnabled)
                    Toggle("Default Session Time", isOn: $useDefaultTime)
                }
                .toggleStyle(SwitchToggleStyle(tint: .green))
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .frame(width: 368)
                
                Button(action: {
                    withAnimation(.spring()) {
                        showAboutUs.toggle()
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 338, height: 51)
                            .foregroundColor(.white)
                            .cornerRadius(13)
                        Text("About Us")
                            .font(.custom("Manrope-Regular", size: 16))
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                }
                
                if !useDefaultTime {
                    VStack(spacing: 12) {
                        
                        ZStack {
                            Rectangle()
                                .frame(width: 338, height: 51)
                                .foregroundColor(.white)
                                .cornerRadius(13)
                            HStack {
                                Spacer()
                                Text("Session time:")
                                    .frame(width: 98, height: 38, alignment: .leading)
                                    .font(.custom("Manrope-Regular", size: 16))
                                Spacer()
                                TimeTextField(timeText: $sessionTime)
                                    .frame(width: 140, height: 38)
                                    .background(Color(hex: "#CFE9DA"))
                                    .cornerRadius(8)
                                Spacer()
                            }
                            
                        }
                        Button(action: {
                            if isValidTimeFormat(sessionTime) {
                                
                            } else { 
                                sessionTime = "15:00"
                            }
                        }) {
                            Text("Save time")
                                .font(.custom("Manrope-SemiBold", size: 18))
                                .frame(width: 180, height: 50)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }

                    }
                }
                
                Spacer()
            }
            .ignoresSafeArea()
            
        }
        .fullScreenCover(isPresented: $showAboutUs) {
            AboutUsView()
                .statusBarHidden(true)
        }
    }
    func isValidTimeFormat(_ time: String) -> Bool {
        let components = time.split(separator: ":")
        guard components.count == 2,
              let minutes = Int(components[0]),
              let seconds = Int(components[1]) else {
            return false
        }
        return (minutes <= 60 && seconds <= 60)
    }

}


#Preview {
    SettingsView()
}

import SwiftUI

struct AboutUsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.019607843831181526, green: 0.3294117748737335, blue: 0.14901961386203766, alpha: 1)).ignoresSafeArea()

            VStack(spacing: 0) { 
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(#colorLiteral(red: 0.055658284574747086, green: 0.4134615361690521, blue: 0.20512039959430695, alpha: 1)))
                        .frame(height: 167)

                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        .padding(.leading, 50)

                        Spacer()

                        Text("About Us")
                            .font(.custom("LibreBaskerville-Bold", size: 22))
                            .foregroundColor(.white)

                        Spacer()
                        Spacer()  
                    }
                }
                .ignoresSafeArea(.all)
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 24) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                            .padding(.top, 24)

                        Text("In a world of constant noise, notifications, and never-ending to-do lists, we wanted to create something different — something quieter. Rainbow Focus was born from the belief that productivity doesn’t have to feel cold, rushed, or overwhelming. It can be gentle. It can be beautiful. It can be yours.")
                            .font(.custom("Montserrat-Regular", size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Image("onboard2")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .cornerRadius(16)
                            .padding(.horizontal)

                        Text("We believe that focus is not a force — it’s a rhythm. And that rhythm changes with how we feel, what we need, and where we are. That’s why Rainbow Focus offers seven distinct color energies, each one designed to help you connect with a specific mindset — whether you need clarity, momentum, balance, or imagination.")
                            .font(.custom("Montserrat-Regular", size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Image("onboard3")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .cornerRadius(16)
                            .padding(.horizontal)

                        Text("Whether you're a deep thinker, a creative soul, a restless dreamer, or simply someone trying to stay present in a distracted world — we're here for you.")
                            .font(.custom("Montserrat-Medium", size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Text("Thank you for being part of this journey.\nStay focused. Stay colorful.\n— The Rainbow Focus Team")
                            .font(.custom("LibreBaskerville-Bold", size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 40)
                    Spacer().frame(height: 120)
                }
            }
            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    AboutUsView()
}


#Preview {
    AboutUsView()
}

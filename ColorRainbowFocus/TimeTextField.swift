import SwiftUI

struct TimeTextField: View {
    @Binding var timeText: String

    var body: some View {
        TextField("MM:SS", text: Binding(
            get: { timeText },
            set: { newValue in
                timeText = formatInputToTime(newValue)
            }
        ))
        .keyboardType(.numberPad)
        .multilineTextAlignment(.center)
        .font(.custom("Manrope-Regular", size: 16))
    }

    private func formatInputToTime(_ input: String) -> String {
        let digits = input.filter { $0.isNumber }
        var allowed = ""

        for (i, char) in digits.enumerated() {
            if i == 0 {
                if let d = char.wholeNumberValue, d <= 6 {
                    allowed.append(char)
                }
            } else if i == 1 {
                if let first = allowed.first?.wholeNumberValue {
                    if first < 6 || (first == 6 && char == "0") {
                        allowed.append(char)
                    }
                }
            } else if i == 2 {
                if let d = char.wholeNumberValue, d <= 6 {
                    allowed.append(char)
                }
            } else if i == 3 {
                if let third = allowed.dropFirst(2).first?.wholeNumberValue {
                    if third < 6 || (third == 6 && char == "0") {
                        allowed.append(char)
                    }
                }
            }
        }

        let padded = allowed.padding(toLength: 4, withPad: "0", startingAt: 0)
        let min = String(padded.prefix(2))
        let sec = String(padded.suffix(2))
        return "\(min):\(sec)"
    }
}

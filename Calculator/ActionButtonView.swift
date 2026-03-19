import SwiftUI

// Make Action Buttons and Animations for them
struct ActionButtonView: View {
    
    @State var buttonColor: Color = Color("ActionButton")
    @Binding var icon: String
    @Binding var textInfoArray: [String]
    let showTextInfo: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16.0)
            .fill(buttonColor)
            .frame(width: 64.0, height: 64.0)
            .overlay(
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32.0, height: 32.0)
            )
            .onTapGesture {
                textInfoArray.append(icon)
                buttonColor = Color("ActionButtonPress")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    buttonColor = Color("ActionButton")
                }
                showTextInfo()
            }
    }
}

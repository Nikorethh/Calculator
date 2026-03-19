import SwiftUI

struct StandardButtonView: View {
    
    @State var buttonColor: Color = Color("Button")
    let standardButtonWidth: CGFloat
    let standardButtonNumber: String
    let onAddNumber: (String) -> Void
    let showTextInfo: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16.0)
            .fill(buttonColor)
            .frame(width: standardButtonWidth, height: 64.0)
            .overlay(
                Text(standardButtonNumber)
                    .foregroundStyle(Color("Text"))
                    .font(.custom("Inter18pt-SemiBold", size: 24.0))
            )
        
            .onTapGesture {
                // textInfoArray.append(standardButtonNumber)
                onAddNumber(standardButtonNumber)
                buttonColor = Color("ButtonPress")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    buttonColor = Color("Button")
                }
                showTextInfo()
            }
    }
}

import SwiftUI

struct TabBarView: View {
    let lightThemeIsActive: Bool
    
    var body: some View {
        HStack(spacing: 0.0) {
            UnevenRoundedRectangle(
                topLeadingRadius: 16.0,
                bottomLeadingRadius: 16.0,
                bottomTrailingRadius: 0.0,
                topTrailingRadius: 0.0
            )
            .fill(Color("Foreground"))
            .frame(width: 64.0, height: 56.0)
            .overlay(
                Image("LightThemeIcon")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(lightThemeIsActive ? Color("ActionButton") : Color("Button"))
                    .scaledToFit()
                    .frame(width: 24.0, height: 24.0)
            )
            .onTapGesture {
                /*if lightThemeIsActive == false {
                    lightThemeIsActive.toggle()
                }*/
            }
            
            UnevenRoundedRectangle(
                topLeadingRadius: 0.0,
                bottomLeadingRadius: 0.0,
                bottomTrailingRadius: 16.0,
                topTrailingRadius: 16.0
            )
            .fill(Color("Foreground"))
            .frame(width: 64.0, height: 56.0)
            .overlay(
                Image("DarkThemeIcon")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(lightThemeIsActive ? Color("Button") : Color("ActionButton"))
                    .scaledToFit()
                    .frame(width: 24.0, height: 24.0)
            )
            .onTapGesture {
                /*if lightThemeIsActive == true {
                    lightThemeIsActive.toggle()
                }*/
            }
        }
    }
}

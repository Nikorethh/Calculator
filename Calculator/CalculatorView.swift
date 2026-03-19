//
//  CalculatorView.swift
//  Calculator
//
//  Created by mac on 20.01.2026.
//

import SwiftUI

struct CalculatorView: View {
    @State var viewModel = CalculatorViewModel()
            
    @State var digitsArray: [String] = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."
    ]
        
    @State var operation: String = ""
                    
//    @State var isButtonPressed: Bool = false
    
    @State var standardButtonColor: Color = Color("Button")
    
    @State var standardButtonNumbers: [Int] = [1, 2, 3]
    
    var standardButtonWidthNormal: CGFloat = 64.0
    
    var standardButtonWidthLarge: CGFloat = 152.0
        
    func resizableText() -> some View {
        let resizableFontSize: CGFloat
        
        switch viewModel.textInfo.count {
        case 0...8:
            resizableFontSize = 64.0
        case 9...12:
            resizableFontSize = 48.0
        case 13...16:
            resizableFontSize = 36.0
        default:
            resizableFontSize = 32.0
        }
        
        return Text(viewModel.textInfo)
            .fixedSize()
            .foregroundStyle(Color("Text"))
            .font(.custom("Inter18pt-SemiBold", size: resizableFontSize))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .lineLimit(1)
        
    }
        
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Color("Background")
                .ignoresSafeArea()
            
            VStack(spacing: 16.0) {
                
                Spacer(minLength: 2.0)
                
                TabBarView(
                    lightThemeIsActive: viewModel.lightThemeIsActive,
                    onSwitchPressed: {
                        viewModel.handleSwitchPressed(isLight: $0)
                    }
                )
                
                Rectangle()
                    .fill(Color("Background"))
                
                VStack(alignment: .trailing, spacing: 0) {
                    Text(viewModel.caption)
                        .foregroundStyle(Color("Caption"))
                        .font(.custom("Inter18pt-SemiBold", size: 18.0))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    resizableText()
                }
                
                .padding(.horizontal, 32.0)
                
                ZStack(alignment: .center) {
                    UnevenRoundedRectangle(
                        topLeadingRadius: 24.0,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 24.0)
                    .fill(Color("Foreground"))
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()
                    
                    VStack(alignment: .center, spacing: 18.0) {
                        
                        Spacer(minLength: 16.0)
                        
                        HStack(spacing: 24.0) {
                            ForEach(0..<4) { icon in
                                ActionButtonView(
                                    icon: viewModel.symbolArray[icon],
                                    addIcon: { icon in
                                        viewModel.textInfoArray.append(icon)
                                    },
                                    showTextInfo: viewModel.showTextInfo
                                )
                            }
                        }
                        
                        HStack(spacing: 24.0) {
                            ForEach(0..<3) { number in
                                StandardButtonView(
                                    standardButtonWidth: standardButtonWidthNormal,
                                    standardButtonNumber: digitsArray[number],
                                    onAddNumber: { value in
                                        viewModel.textInfoArray.append(value)
                                    },
                                    showTextInfo: viewModel.showTextInfo
                                )
                            }
                            
                            ActionButtonView(
                                icon: viewModel.symbolArray[4],
                                addIcon: { icon in
                                    viewModel.textInfoArray.append(icon)
                                },
                                showTextInfo: viewModel.showTextInfo
                            )
                        }
                        
                        HStack(spacing: 24.0) {
                            ForEach(3..<6) { number in
                                StandardButtonView(
                                    standardButtonWidth: standardButtonWidthNormal,
                                    standardButtonNumber: digitsArray[number],
                                    onAddNumber: { value in
                                        viewModel.textInfoArray.append(value)
                                    },
                                    showTextInfo: viewModel.showTextInfo
                                )
                            }
                            
                            ActionButtonView(
                                icon: viewModel.symbolArray[5],
                                addIcon: { icon in
                                    viewModel.textInfoArray.append(icon)
                                },
                                showTextInfo: viewModel.showTextInfo
                            )
                        }
                        
                        HStack(spacing: 24.0) {
                            ForEach(6..<9) { number in
                                StandardButtonView(
                                    standardButtonWidth: standardButtonWidthNormal,
                                    standardButtonNumber: digitsArray[number],
                                    onAddNumber: { value in
                                        viewModel.textInfoArray.append(value)
                                    },
                                    showTextInfo: viewModel.showTextInfo
                                )
                            }
                            
                            ActionButtonView(
                                icon: viewModel.symbolArray[6],
                                addIcon: { icon in
                                    viewModel.textInfoArray.append(icon)
                                },
                                showTextInfo: viewModel.showTextInfo
                            )
                        }
                        
                        HStack(spacing: 24.0) {
                            StandardButtonView(
                                standardButtonWidth: standardButtonWidthLarge,
                                standardButtonNumber: digitsArray[9],
                                onAddNumber: { value in
                                    viewModel.textInfoArray.append(value)
                                },
                                showTextInfo: viewModel.showTextInfo
                            )
                            
                            StandardButtonView(
                                standardButtonWidth: standardButtonWidthNormal,
                                standardButtonNumber: digitsArray[10],
                                onAddNumber: { value in
                                    viewModel.textInfoArray.append(value)
                                },
                                showTextInfo: viewModel.showTextInfo
                            )
                            
                            ActionButtonView(
                                icon: viewModel.symbolArray[7],
                                addIcon: { icon in
                                    viewModel.textInfoArray.append(icon)
                                },
                                showTextInfo: viewModel.showTextInfo
                            )
                        }
                    }
                }
            }
        }
        .preferredColorScheme(viewModel.lightThemeIsActive ? .light : .dark)
    }
}
    
//#Preview {
//    CalculatorView(lightThemeIsActive: $lightThemeIsActive)
//}

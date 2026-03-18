//
//  CalculatorApp.swift
//  Calculator
//
//  Created by mac on 10.01.2026.
//

import SwiftUI

@main
struct CalculatorApp: App {
    
    @State var lightThemeIsActive: Bool = true
    
    var body: some Scene {
        WindowGroup {
            CalculatorView(lightThemeIsActive: $lightThemeIsActive)
                .preferredColorScheme(lightThemeIsActive ? .light : .dark)
        }
    }
}

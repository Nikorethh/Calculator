//
//  CalculatorView.swift
//  Calculator
//
//  Created by mac on 20.01.2026.
//

import SwiftUI

struct CalculatorView: View {
    @State var textInfoArray: [String] = []
    
    @State var textInfo: String = "0"
    
    @State var simplifiedTextInfo: String = ""
    
    @State var symbolArray: [String] = [
        "Delete", "PlusMinus", "Percent", "Divide", "Multiply", "Minus", "Plus", "Equal"
    ]
    
    @State var digitsArray: [String] = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "."
    ]
    
    @State var caption: String = ""
    
    @State var operation: String = ""
    
    @State var arrayOfOperations: [String] = []
    
    @State var arrayOfNumbers: [Double] = []
    
    @State var plusMinusIsActive: Bool = false
    
    @State var isNumber: Bool = false
    
//    @State var isButtonPressed: Bool = false
    
    @State var standardButtonColor: Color = Color("Button")
    
    @State var standardButtonNumbers: [Int] = [1, 2, 3]
    
    @State var standardButtonWidthNormal: CGFloat = 64.0
    
    @State var standardButtonWidthLarge: CGFloat = 152.0
    
    @Binding var lightThemeIsActive: Bool
    
    
    func showTextInfo() {
        
        while textInfoArray.count != 0 {
            let symbol = textInfoArray.removeFirst()
            var operation: String = ""
            
            switch symbol {
            case "Delete":
                if textInfo.count != 1 {
                    textInfo.removeLast()
                } else {
                    textInfo = "0"
                }
            case "PlusMinus":
                var temporaryArrayOfNumbers: [String] = []
                var temporaryArrayOfOperations: [String] = []
                var finalArray: [String] = []
                var temporaryTextInfo: String = textInfo
                var number: String = ""
                
                temporaryTextInfo.append("=")
                
                while temporaryTextInfo.count != 0 {
                    let symbol = temporaryTextInfo.removeFirst()
                    
                    switch symbol {
                    case "+", "-", "*", "/":
                        temporaryArrayOfOperations.append(String(symbol))
                        temporaryArrayOfNumbers.append(number)
                        number = ""
                    case "=":
                        temporaryArrayOfNumbers.append(number)
                        number = ""
                    default:
                        number += String(symbol)
                    }
                }
                
                while temporaryArrayOfNumbers.count != 0 {
                    if temporaryArrayOfNumbers.count != 0 && temporaryArrayOfOperations.count != 0 {
                        let number = temporaryArrayOfNumbers.removeFirst()
                        finalArray.append(number)
                        
                        let operation = temporaryArrayOfOperations.removeFirst()
                        finalArray.append(operation)
                    } else if temporaryArrayOfNumbers.count != 0 && temporaryArrayOfOperations.count == 0 {
                        let number = temporaryArrayOfNumbers.removeFirst()
                        finalArray.append(number)
                    }
                }
                
                plusMinusIsActive.toggle()
                
                if plusMinusIsActive == true {
                    let lastNumber: String = finalArray.removeLast()
                    finalArray.append("(")
                    finalArray.append("-")
                    finalArray.append(lastNumber)
                    finalArray.append(")")
                    
                    textInfo = finalArray.joined()
                } else if plusMinusIsActive == false && finalArray.last!.last == ")" {
                    var lastNumber = finalArray.removeLast()
                    
                    if lastNumber.last == ")" {
                        lastNumber.removeLast()
                    }
                    
                    finalArray.removeLast()
                    finalArray.removeLast()
                    
                    finalArray.append(lastNumber)
                    
                    textInfo = finalArray.joined()
                } else {
                    let lastNumber: String = finalArray.removeLast()
                    finalArray.append("(")
                    finalArray.append("-")
                    finalArray.append(lastNumber)
                    finalArray.append(")")
                    
                    textInfo = finalArray.joined()
                    
                    plusMinusIsActive.toggle()
                }
                
                
            case "Percent":
                operation = "%"
            case "Divide":
                operation += "/"
            case "Multiply":
                operation += "*"
            case "Minus":
                operation += "-"
            case "Plus":
                operation += "+"
            case "Equal":
                caption = textInfo
                if textInfo.contains("(") || textInfo.contains(")") {
                    simplifiedTextInfo = getSimpifiedTextInfo()
                } else {
                    simplifiedTextInfo = textInfo
                }
                getMathData()
                defineCompoundOperations()
                getCalculations()
                textInfo = showDecimalNumbers()
            default:
                if textInfo.first == "0" {
                    textInfo.removeFirst()
                    textInfo += symbol
                } else {
                    textInfo += symbol
                }
                
            }
            textInfo += operation
        }
    }
    
    func getSimpifiedTextInfo() -> String {
        var temporaryTextInfo: String = textInfo
        var arrayOfCompoundData: [String] = []
        var arrayOfOrdinaryData: [String] = []
        var commonArray: [String] = []
        var result: String = ""
        var firstSymbol: String = ""
        var stringToAdd: String = ""
        temporaryTextInfo += "="

        var firstSymbolIsBracket: Bool = false

        if textInfo.first == "(" {
            firstSymbolIsBracket = true
        }

        while !temporaryTextInfo.isEmpty {
            
            firstSymbol = String(describing: temporaryTextInfo.removeFirst())
            
            if firstSymbol == "(" {
                
                firstSymbol = ""
                arrayOfOrdinaryData.append(stringToAdd)
                stringToAdd = ""
                
                while temporaryTextInfo.first != ")" {
                    stringToAdd += String(temporaryTextInfo.removeFirst())
                }
                arrayOfCompoundData.append(stringToAdd)
                temporaryTextInfo.removeFirst()
                stringToAdd = ""
                
            } else if firstSymbol == "=" {
                arrayOfOrdinaryData.append(stringToAdd)
            }
            
            stringToAdd += firstSymbol
            
        }

        if arrayOfOrdinaryData.first == "" {
            arrayOfOrdinaryData.removeFirst()
        }

        if arrayOfOrdinaryData.last == "" {
            arrayOfOrdinaryData.removeLast()
        }

        let counterForArayOfOrdinaryData: Int = arrayOfOrdinaryData.count
        let counterForArrayOfCompoundData: Int = arrayOfCompoundData.count

        if counterForArayOfOrdinaryData > counterForArrayOfCompoundData && firstSymbolIsBracket == false {
            
            while !arrayOfOrdinaryData.isEmpty {
                
                if !arrayOfOrdinaryData.isEmpty {
                    let firstElement = arrayOfOrdinaryData.removeFirst()
                    commonArray.append(firstElement)
                }
                
                if !arrayOfCompoundData.isEmpty {
                    let firstElement = arrayOfCompoundData.removeFirst()
                    commonArray.append(firstElement)
                }
                
            }
            
        } else if counterForArayOfOrdinaryData < counterForArrayOfCompoundData && firstSymbolIsBracket == false {
            
            while !arrayOfCompoundData.isEmpty {
                
                if !arrayOfOrdinaryData.isEmpty {
                    let firstElement = arrayOfOrdinaryData.removeFirst()
                    commonArray.append(firstElement)
                }
                
                if !arrayOfCompoundData.isEmpty {
                    let firstElement = arrayOfCompoundData.removeFirst()
                    commonArray.append(firstElement)
                }
                
            }
            
        } else if counterForArayOfOrdinaryData == counterForArrayOfCompoundData && firstSymbolIsBracket == false {
            
            while !arrayOfCompoundData.isEmpty {
                
                if !arrayOfOrdinaryData.isEmpty {
                    let firstElement = arrayOfOrdinaryData.removeFirst()
                    commonArray.append(firstElement)
                }
                
                if !arrayOfCompoundData.isEmpty {
                    let firstElement = arrayOfCompoundData.removeFirst()
                    commonArray.append(firstElement)
                }
                
            }
            
        } else if counterForArayOfOrdinaryData < counterForArrayOfCompoundData && firstSymbolIsBracket == true {
            
            while !arrayOfCompoundData.isEmpty {
                
                if !arrayOfCompoundData.isEmpty {
                    let firstElement = arrayOfCompoundData.removeFirst()
                    commonArray.append(firstElement)
                }
                
                if !arrayOfOrdinaryData.isEmpty {
                    let firstElement = arrayOfOrdinaryData.removeFirst()
                    commonArray.append(firstElement)
                }
                
            }
            
        } else if counterForArayOfOrdinaryData > counterForArrayOfCompoundData && firstSymbolIsBracket == true {
            
            while !arrayOfCompoundData.isEmpty {
                
                if !arrayOfCompoundData.isEmpty {
                    let firstElement = arrayOfCompoundData.removeFirst()
                    commonArray.append(firstElement)
                }
                
                if !arrayOfOrdinaryData.isEmpty {
                    let firstElement = arrayOfOrdinaryData.removeFirst()
                    commonArray.append(firstElement)
                }
                
            }
            
        } else if counterForArayOfOrdinaryData == counterForArrayOfCompoundData && firstSymbolIsBracket == true {
            
            while !arrayOfCompoundData.isEmpty && !arrayOfOrdinaryData.isEmpty {
                    let firstElement = arrayOfCompoundData.removeFirst()
                    commonArray.append(firstElement)
                
                    let secondElement = arrayOfOrdinaryData.removeFirst()
                    commonArray.append(secondElement)
                }
        }
            
        result = commonArray.joined()

        var symbols: String = ""
        var compoundOperation: String = ""

        while !result.isEmpty {
            
            let firstSymbol = String(describing: result.removeFirst())
            
            switch firstSymbol {
            case "+", "-", "*", "/", "%":
                if result.first == "-" {
                    compoundOperation += firstSymbol + String(describing: result.removeFirst())
                    
                    switch compoundOperation {
                    case "+-":
                        symbols += "-"
                    case "--":
                        symbols += "+"
                    case "*-":
                        symbols += "&"
                    case "/-":
                        symbols += "@"
                    default:
                        symbols += "$"
                    }
                    
                    compoundOperation = ""
                    
                } else {
                    symbols += firstSymbol
                }
            default:
                symbols += firstSymbol
            }
        }

        result = symbols
        return result
    }
    
    func getMathData() {
        var symbols: String = simplifiedTextInfo
        var number: String = ""
        var counter: Int = 0
        var storageOfWrongCalculations: [Int] = []
        
        if symbols.count != 0 {
            symbols.append("=")
        }
        
        while symbols.count != 0 {
            let symbol = symbols.removeFirst()
            
            switch symbol {
            case "+":
                arrayOfOperations.append("+")
                if isNumber == true {
                    arrayOfNumbers.append(Double("-" + number) ?? 0)
                    isNumber.toggle()
                } else {
                    arrayOfNumbers.append(Double(number) ?? 0)
                }
                if arrayOfNumbers.last == 0 {
                    storageOfWrongCalculations.append(counter)
                }
                number = ""
                counter += 1
            case "-":
                arrayOfOperations.append("-")
                if isNumber == true {
                    arrayOfNumbers.append(Double("-" + number) ?? 0)
                    isNumber.toggle()
                } else {
                    arrayOfNumbers.append(Double(number) ?? 0)
                }
                if arrayOfNumbers.last == 0 {
                    storageOfWrongCalculations.append(counter)
                }
                number = ""
                counter += 1
            case "*":
                arrayOfOperations.append("*")
                if isNumber == true {
                    arrayOfNumbers.append(Double("-" + number) ?? 0)
                    isNumber.toggle()
                } else {
                    arrayOfNumbers.append(Double(number) ?? 0)
                }
                number = ""
                if arrayOfNumbers.last == 0 {
                    storageOfWrongCalculations.append(counter)
                }
                counter += 1
            case "/":
                arrayOfOperations.append("/")
                if isNumber == true {
                    arrayOfNumbers.append(Double("-" + number) ?? 0)
                    isNumber.toggle()
                } else {
                    arrayOfNumbers.append(Double(number) ?? 0)
                }
                if arrayOfNumbers.last == 0 {
                    storageOfWrongCalculations.append(counter)
                }
                number = ""
                counter += 1
            case "%":
                arrayOfOperations.append("%")
                arrayOfNumbers.append(Double(number) ?? 0)
                number = ""
                if arrayOfNumbers.last == 0 {
                    storageOfWrongCalculations.append(counter)
                }
                counter += 1
                isNumber = true
            case "&":
                arrayOfOperations.append("*")
                arrayOfNumbers.append(Double(number) ?? 0)
                number = ""
                if arrayOfNumbers.last == 0 {
                    storageOfWrongCalculations.append(counter)
                }
                counter += 1
                isNumber.toggle()
            case "@":
                arrayOfOperations.append("/")
                arrayOfNumbers.append(Double(number) ?? 0)
                number = ""
                if arrayOfNumbers.last == 0 {
                    storageOfWrongCalculations.append(counter)
                }
                counter += 1
                isNumber.toggle()
            case "=":
                arrayOfNumbers.append(Double(number) ?? 0)
                number = ""
                if arrayOfNumbers.last == 0 {
                    storageOfWrongCalculations.append(counter)
                }
                counter += 1
            default:
                number += String(symbol)
            }
        }
        
        while storageOfWrongCalculations.count != 0 {
            let wrongCalculation = storageOfWrongCalculations.removeFirst()
            
            arrayOfNumbers.remove(at: wrongCalculation)
        }
    }
    
    func defineCompoundOperations() {
        var temporaryArrayOfOperations: [String] = arrayOfOperations
        var arrayOfcompoundOperations: [String] = []
        var indicesOfCompoundOperations: [Int] = []
        var arrayOfPercentOperations: [String] = []
        var indicesOfPercentOperations: [Int] = []
        var counter: Int = 0
        
        while temporaryArrayOfOperations.count != 0 {
            let operation = temporaryArrayOfOperations.removeFirst()
                
            switch operation {
            case "*":
                counter += 1
                arrayOfcompoundOperations.append(operation)
                indicesOfCompoundOperations.append(counter - 1)
            case "/":
                counter += 1
                arrayOfcompoundOperations.append(operation)
                indicesOfCompoundOperations.append(counter - 1)
            case "%":
                counter += 1
                arrayOfPercentOperations.append(operation)
                indicesOfPercentOperations.append(counter - 1)
            default:
                counter += 1
            }
        }
        
        
        while arrayOfPercentOperations.count != 0 {
            let percentOperation = arrayOfPercentOperations.removeFirst()
            
            let mathAction = arrayOfNumbers[indicesOfPercentOperations[0]] * 0.01
            arrayOfNumbers.remove(at: indicesOfPercentOperations[0])
            arrayOfNumbers.insert(mathAction, at: indicesOfCompoundOperations[0] + 1)
            arrayOfOperations.remove(at: indicesOfPercentOperations[0])
            indicesOfPercentOperations.remove(at: 0)
            if !indicesOfPercentOperations.isEmpty {
                var number = indicesOfPercentOperations[0]
                number -= 1
                indicesOfPercentOperations.remove(at: 0)
                indicesOfPercentOperations.insert(number, at: 0)
            }
        }
        
        while arrayOfcompoundOperations.count != 0 {
            let compoundOperation = arrayOfcompoundOperations.removeFirst()
                
            switch compoundOperation {
            case "*":
                let mathAction = arrayOfNumbers[indicesOfCompoundOperations[0]] * arrayOfNumbers[indicesOfCompoundOperations[0] + 1]
                arrayOfNumbers.remove(atOffsets: [indicesOfCompoundOperations[0], indicesOfCompoundOperations[0] + 1])
                arrayOfNumbers.insert(mathAction, at: indicesOfCompoundOperations[0])
                arrayOfOperations.remove(at: indicesOfCompoundOperations[0])
                indicesOfCompoundOperations.remove(at: 0)
                if !indicesOfCompoundOperations.isEmpty {
                    var number = indicesOfCompoundOperations[0]
                    number -= 1
                    indicesOfCompoundOperations.remove(at: 0)
                    indicesOfCompoundOperations.insert(number, at: 0)
                }
            case "/":
                let mathAction = arrayOfNumbers[indicesOfCompoundOperations[0]] / arrayOfNumbers[indicesOfCompoundOperations[0] + 1]
                arrayOfNumbers.remove(atOffsets: [indicesOfCompoundOperations[0], indicesOfCompoundOperations[0] + 1])
                arrayOfOperations.remove(at: indicesOfCompoundOperations[0])
                arrayOfNumbers.insert(mathAction, at: indicesOfCompoundOperations[0])
                indicesOfCompoundOperations.remove(at: 0)
                if !indicesOfCompoundOperations.isEmpty {
                    var number = indicesOfCompoundOperations[0]
                    number -= 1
                    indicesOfCompoundOperations.remove(at: 0)
                    indicesOfCompoundOperations.insert(number, at: 0)
                }
            case "%":
                let mathAction = arrayOfNumbers[indicesOfCompoundOperations[0]] * 0.01
                arrayOfNumbers.remove(at: indicesOfCompoundOperations[0])
                arrayOfOperations.remove(at: indicesOfCompoundOperations[0])
                arrayOfNumbers.insert(mathAction, at: indicesOfCompoundOperations[0])
                if !indicesOfCompoundOperations.isEmpty {
                    var number = indicesOfCompoundOperations[0]
                    number -= 1
                    indicesOfCompoundOperations.remove(at: 0)
                    indicesOfCompoundOperations.insert(number, at: 0)
                }
            default:
                break
                }
            }
        }
    
    func getCalculations() {
        
        while arrayOfNumbers.count != 1 && arrayOfOperations.count != 0 {
            print(arrayOfOperations)
            print(arrayOfNumbers)
            let operation = arrayOfOperations.removeFirst()
            
            switch operation {
            case "+":
                let mathAction = arrayOfNumbers[0] + arrayOfNumbers[1]
                arrayOfNumbers.remove(atOffsets: [0, 1])
                arrayOfNumbers.insert(mathAction, at: 0)
            case "-":
                let mathAction = arrayOfNumbers[0] - arrayOfNumbers[1]
                arrayOfNumbers.remove(atOffsets: [0, 1])
                arrayOfNumbers.insert(mathAction, at: 0)
            default:
                break
            }
        }
    }
    
    func showDecimalNumbers() -> String {
        var number = String(arrayOfNumbers[0])
        var lastNumbers: [String] = []
        
        while number.last != "." {
            let symbol = number.removeLast()
            
            if symbol != "." {
                lastNumbers.append(String(symbol))
            }
        }
        
        lastNumbers.reverse()
        let combinedInfo = lastNumbers.joined()
        
        if Double(combinedInfo)! > 0 {
            return String(arrayOfNumbers.removeFirst())
        } else {
            return String(Int(arrayOfNumbers.removeFirst()))
        }
    }
    
    func resizableText() -> some View {
        let resizableFontSize: CGFloat
        
        switch textInfo.count {
        case 0...8:
            resizableFontSize = 64.0
        case 9...12:
            resizableFontSize = 48.0
        case 13...16:
            resizableFontSize = 36.0
        default:
            resizableFontSize = 32.0
        }
        
        return Text(textInfo)
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
                
                TabBarView(lightThemeIsActive: $lightThemeIsActive)
                
                Rectangle()
                    .fill(Color("Background"))
                
                VStack(alignment: .trailing, spacing: 0) {
                    Text(caption)
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
                                ActionButtonView(icon: $symbolArray[icon], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                            }
                        }
                        
                        HStack(spacing: 24.0) {
                            ForEach(0..<3) { number in
                                StandardButtonView(standardButtonWidth: $standardButtonWidthNormal, standardButtonNumber: $digitsArray[number], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                            }
                            
                            ActionButtonView(icon: $symbolArray[4], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                        }
                        
                        HStack(spacing: 24.0) {
                            ForEach(3..<6) { number in
                                StandardButtonView(standardButtonWidth: $standardButtonWidthNormal, standardButtonNumber: $digitsArray[number], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                            }
                            
                            ActionButtonView(icon: $symbolArray[5], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                        }
                        
                        HStack(spacing: 24.0) {
                            ForEach(6..<9) { number in
                                StandardButtonView(standardButtonWidth: $standardButtonWidthNormal, standardButtonNumber: $digitsArray[number], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                            }
                            
                            ActionButtonView(icon: $symbolArray[6], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                        }
                        
                        HStack(spacing: 24.0) {
                            StandardButtonView(standardButtonWidth: $standardButtonWidthLarge, standardButtonNumber: $digitsArray[9], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                            StandardButtonView(standardButtonWidth: $standardButtonWidthNormal, standardButtonNumber: $digitsArray[10], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                            ActionButtonView(icon: $symbolArray[7], textInfoArray: $textInfoArray, showTextInfo: showTextInfo)
                        }
                    }
                }
            }
        }
    }
}
    
struct StandardButtonView: View {
    
    @State var buttonColor: Color = Color("Button")
    @Binding var standardButtonWidth: CGFloat
    @Binding var standardButtonNumber: String
    @Binding var textInfoArray: [String]
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
                textInfoArray.append(standardButtonNumber)
                buttonColor = Color("ButtonPress")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    buttonColor = Color("Button")
                }
                showTextInfo()
            }
    }
}

//#Preview {
//    CalculatorView(lightThemeIsActive: $lightThemeIsActive)
//}

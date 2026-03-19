import SwiftUI

@Observable
class CalculatorViewModel {
    var textInfo: String = "0"
    var lightThemeIsActive: Bool = true
    
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
}

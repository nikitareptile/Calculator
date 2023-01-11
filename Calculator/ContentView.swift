//
//  ContentView.swift
//  Calculator
//
//  Created by Никита Тихонюк on 11.01.2023.
//

import SwiftUI

enum CalculatorButton: String {
    case zero       = "0"
    case one        = "1"
    case two        = "2"
    case three      = "3"
    case four       = "4"
    case five       = "5"
    case six        = "6"
    case seven      = "7"
    case eight      = "8"
    case nine       = "9"
    case add        = "+"
    case substract  = "–"
    case multiply   = "x"
    case divide     = "/"
    case equal      = "="
    case decimal    = "."
    case percent    = "%"
    case negative   = "-/+"
    case clear      = "AC"
    
    var buttonColor: Color {
        switch self {
        case .add, .substract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}

enum Operation {
    case add, substract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Text(value)
                        .lineLimit(1)
                        .font(.system(size: 100))
                        .minimumScaleFactor(0.5)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.tapOn(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.title)
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            })

                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
    func tapOn(button: CalculatorButton) {
        switch button {
        case .add, .substract, .multiply, .divide, .equal:
            switch button {
            case .add:
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            case .substract:
                self.currentOperation = .substract
                self.runningNumber = Int(self.value) ?? 0
            case .multiply:
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            case .divide:
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            case .equal:
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                case .substract:
                    self.value = "\(runningValue - currentValue)"
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            default:
                self.currentOperation = .none
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            //TODO
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalculatorButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2.07
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

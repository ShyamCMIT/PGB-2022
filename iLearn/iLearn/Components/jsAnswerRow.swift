//
//  jsAnswerRow.swift
//  iLearn
//
//  Created by Shyam sai Dogga on 24/03/22.
//

import SwiftUI

struct jsAnswerRow: View {
    @EnvironmentObject var jsManager: JsManager
    var jsanswer: jsAnswer
    @State private var isSelected = false

    // Custom colors
    var green = Color(hue: 0.437, saturation: 0.711, brightness: 0.711)
    var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(jsanswer.text)
                .bold()
            
            if isSelected {
                Spacer()
                
                Image(systemName: jsanswer.isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                    .foregroundColor(jsanswer.isCorrect ? green : red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(jsManager.answerSelected ? (isSelected ? Color("AccentColor") : .gray) : Color("AccentColor"))
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? jsanswer.isCorrect ? green : red : .gray, radius: 5, x: 0.5, y: 0.5)
        .onTapGesture {
            if !jsManager.answerSelected {
                isSelected = true
                jsManager.selectAnswer(jsanswer: jsanswer)

            }
        }
    }
}

struct jsAnswerRow_Previews: PreviewProvider {
    static var previews: some View {
        jsAnswerRow(jsanswer: jsAnswer(text: "Single", isCorrect:  false))
            .environmentObject(JsManager())
    }
}

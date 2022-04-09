//
//  AnswerRow.swift
//  iLearn
//
//  Created by Shyam sai Dogga on 24/03/22.
//

import SwiftUI

struct AnswerRow: View {
    @EnvironmentObject var ilearnManager: iLearnManager
    var answer: Answer
    @State private var isSelected = false

    // Custom colors
    var green = Color(hue: 0.437, saturation: 0.711, brightness: 0.711)
    var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(answer.text)
                .bold()
            
            if isSelected {
                Spacer()
                
                Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "checkmark.circle.fill")
                    .foregroundColor(answer.isCorrect ? green : green)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(ilearnManager.answerSelected ? (isSelected ? Color("AccentColor") : .gray) : Color("AccentColor"))
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? answer.isCorrect ? green : green : .gray, radius: 5, x: 0.5, y: 0.5)
        .onTapGesture {
            if !ilearnManager.answerSelected {
                isSelected = true
                ilearnManager.selectAnswer(answer: answer)

            }
        }
    }
}

struct AnswerRow_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRow(answer: Answer(text: "Single", isCorrect:  false))
            .environmentObject(iLearnManager())
    }
}

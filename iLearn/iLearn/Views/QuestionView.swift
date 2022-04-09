//
//  QuestionView.swift
//  iLearn
//
//  Created by Shyam sai Dogga on 24/03/22.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var ilearnManager: iLearnManager

    var body: some View {
        VStack(spacing: 40) {
            HStack {
               
                Text(" iSpace \n MVGRCE")
                    .lilacTitle()
                
                Spacer()
               
                
                
                Spacer()
                
                Text("\(ilearnManager.index + 1) of \(ilearnManager.length)")
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.heavy)
            }
            
            ProgressBar(progress: ilearnManager.progress)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(ilearnManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.gray)
                
                ForEach(ilearnManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(ilearnManager)
                }
            }
            
            Button {
                ilearnManager.goToNextQuestion()
            } label: {
                PrimaryButton(text: "Next", background: ilearnManager.answerSelected ? Color("AccentColor") : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
            }
            .disabled(!ilearnManager.answerSelected)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.white)
        .navigationBarHidden(true)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .environmentObject(iLearnManager())
    }
}

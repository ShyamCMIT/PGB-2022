//
//  jsQuestionView.swift
//  iLearn
//
//  Created by Shyam sai Dogga on 24/03/22.
//

import SwiftUI

struct JsQuestionView: View {
    @EnvironmentObject var jsManager: JsManager

    var body: some View {
        VStack(spacing: 40) {
            HStack {
                
                Text(" iSpace \nJavaScript Level")
                    .lilacTitle()
                
                Spacer()
                
                Text("\(jsManager.index + 1) of \(jsManager.length)")
                    .foregroundColor(Color("AccentColor"))
                    .fontWeight(.heavy)
            }
            
            ProgressBar(progress: jsManager.progress)
            
            VStack(alignment: .leading, spacing: 20) {
                Text(jsManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.gray)
                
                ForEach(jsManager.answerChoices, id: \.id) { answer in
                    jsAnswerRow(jsanswer: answer)
                        .environmentObject(jsManager)
                }
            }
            
            Button {
                jsManager.goToNextQuestion()
            } label: {
                PrimaryButton(text: "Next", background: jsManager.answerSelected ? Color("AccentColor") : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
            }
            .disabled(!jsManager.answerSelected)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.white)
        .navigationBarHidden(true)
    }
}

struct JsQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        JsQuestionView()
            .environmentObject(JsManager())
    }
}

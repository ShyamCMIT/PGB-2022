//
//  iLearnView.swift
//  iLearn
//
//  Created by Shyam sai Dogga on 24/03/22.
//

import SwiftUI

struct iLearnView: View {
    @EnvironmentObject var ilearnManager: iLearnManager
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        if ilearnManager.reachedEnd {
            VStack(spacing: 20) {
                Text("iSpace-MVGRCE")
                    .lilacTitle()

                Text("Good Luck, check your domain efficiency")
                
                Text("Efficiency is \(ilearnManager.score * 10)%")
                
                Button {
                    Task.init {
                        await ilearnManager.fetchiLearn()
                    }
                } label: {
                    PrimaryButton(text: "Try Again?")
                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Back to Home Page!")
                })
            }
            .foregroundColor(Color("AccentColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
        } else {
            QuestionView()
                .environmentObject(ilearnManager)
        }
    }
}

struct iLearnView_Previews: PreviewProvider {
    static var previews: some View {
        iLearnView()
            .environmentObject(iLearnManager())
    }
}

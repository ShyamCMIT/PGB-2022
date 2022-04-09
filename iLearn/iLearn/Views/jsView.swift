//
//  jsView.swift
//  iLearn
//
//  Created by Shyam sai Dogga on 24/03/22.
//

import SwiftUI

struct JsView: View {
    @EnvironmentObject var jsManager: JsManager
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        if jsManager.reachedEnd {
            VStack(spacing: 20) {
                Text("iSpace-JavaScript")
                    .lilacTitle()

                Text("Good Luck, check your score")
                
                Text("You have scored \(jsManager.score) out of \(jsManager.length)")
                
                Button {
                    Task.init {
                        await jsManager.fetchiLearn()
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
            JsQuestionView()
                .environmentObject(jsManager)
        }
    }
}

struct JsView_Previews: PreviewProvider {
    static var previews: some View {
        JsView()
            .environmentObject(JsManager())
    }
}


//
//  Answer.swift
//  iLearn
//
//  Created by Shyam sai Dogga on 24/03/22.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID() // Setting the UUID ourselves inside of the model, because API doesn't return a unique ID for each answer
    var text: AttributedString
    var isCorrect: Bool
}

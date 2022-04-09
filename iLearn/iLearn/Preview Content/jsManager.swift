//
//  jsManager.swift
//  iLearn
//
//  Created by Shyam sai Dogga on 24/03/22.
//
import Foundation
import SwiftUI

class JsManager: ObservableObject {
    // Variables to set ilearn and length of ilearn
    private(set) var Js: [js.Result] = []
    @Published private(set) var length = 0
    
    // Variables to set question and answers
    @Published private(set) var index = 0
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [jsAnswer] = []
    
    // Variables for score and progress
    @Published private(set) var score = 0
    @Published private(set) var progress: CGFloat = 0.00
    
    // Variables to know if an answer has been selected and reached the end of ilearn
    @Published private(set) var answerSelected = false
    @Published private(set) var reachedEnd = false
    
    // Call the fetchiLearn function on intialize of the class, asynchronously
    init() {
        Task.init {
            await fetchiLearn()
        }
    }
    
    // Asynchronous HTTP request to get the ilearn questions and answers
    func fetchiLearn() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

            let decoders = JSONDecoder()
            // Line below allows us to convert the correct_answer key from the API into the correctAnswer in our iLearn model, without running into an error from the JSONDecoder that it couldn't find a matching codingKey
            decoders.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoders.decode(js.self, from: data)

            DispatchQueue.main.async {
                // Reset variables before assigning new values, for when the user plays the game another time
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false

                // Set new values for all variables
                self.Js = decodedData.results
                self.length = self.Js.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching stuff: \(error)")
        }
    }
    
    // Function to go to next question. If reached end of the trivia, set reachedEnd to true
    func goToNextQuestion() {
        // If didn't reach end of array, increment index and set next question
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            // If reached end of array, set reachedEnd to true
            reachedEnd = true
        }
    }
    
    // Function to set a new question and answer choices, and update the progress
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double((index + 1)) / Double(length) * 350)

        // Only setting next question if index is smaller than the ilearn's length
        if index < length {
            let currentiLearnQuestion = Js[index]
            question = currentiLearnQuestion.formattedQuestion
            answerChoices = currentiLearnQuestion.answers
        }
    }
    
    // Function to know that user selected an answer, and update the score
    func selectAnswer(jsanswer: jsAnswer) {
        answerSelected = true
        
        // If answer is correct, increment score
        if jsanswer.isCorrect {
            score += 1
        }
    }
}

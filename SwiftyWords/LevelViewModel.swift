//
//  LearnViewModel.swift
//  SwiftyWords
//
//  Created by Hans Cathcart on 4/22/23.
//

import Foundation

class LevelViewModel: ObservableObject {
    private(set) var answers: [Answer]
    private(set) var segments: [Segment]
    private var player: Player
    @Published var selectedSegments = [Int]()
    @Published var playAnimation: Bool
    @Published var counter: Int

    init(words: [Word], player: Player) {
        answers = words.map(Answer.init)
        segments = words.flatMap(\.segments).shuffled().map(Segment.init)
        self.player = player
        self.playAnimation = false
        self.counter = 0
    }
    
    var currentAnswer: String {
        if selectedSegments.isEmpty {
            return " "
        } else {
            return selectedSegments.map { segments[$0].text }.joined()
        }
    }
    
    func select(_ index: Int) {
        segments[index].isUsed = true
        selectedSegments.append(index)
        
        let userAnswer = currentAnswer
        
        let match = answers.firstIndex {
            $0.word.solution == userAnswer
        }
        
        if let match {
            player.score += 1
            selectedSegments.removeAll()
            answers[match].isSolved = true
            counter += 1
        }
        
        if counter == 7 {
            playAnimation = true
        }
    }
    
    func delete() {
        if let removed = selectedSegments.popLast() {
            segments[removed].isUsed = false
        }
    }
}

//
//  ScoreViewModel.swift
//  SwiftyWords
//
//  Created by Hans Cathcart on 4/23/23.
//

import Foundation

class Player: ObservableObject {
    @Published var score: Int

    init() {
        self.score = 0
    }
}

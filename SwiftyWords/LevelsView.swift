//
//  LevelsView.swift
//  SwiftyWords
//
//  Created by Hans Cathcart on 4/22/23.
//

import SwiftUI

struct LevelsView: View {
    var category: Category
    
    @ObservedObject var player: Player
    
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack {
                List(0..<category.levels.count, id: \.self) { number in
                    NavigationLink(value: number) {
                        Text("Level \(number + 1)")
                    }
                }
                .navigationDestination(for: Int.self) { level in
                    ContentView(category: category, levelNumber: level, player: player)
                }
                .navigationTitle(category.name)
                .navigationBarTitleDisplayMode(.inline)
                ScoreView(player: player)
            }
        } else {
            VStack {
                List(0..<category.levels.count, id: \.self) { number in
                    Text("Level \(number + 1)")
                }
                .navigationTitle(category.name)
                .navigationBarTitleDisplayMode(.inline)
                ScoreView(player: player)
            }
        }
    }
}
    
    struct LevelsView_Previews: PreviewProvider {
        static var previews: some View {
            LevelsView(category: .example, player: Player())
        }
    }

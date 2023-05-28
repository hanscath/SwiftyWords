//
//  ContentView.swift
//  SwiftyWords
//
//  Created by Hans Cathcart on 4/22/23.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    @StateObject private var model: LevelViewModel
    @ObservedObject var player: Player

    var category: Category
    var levelNumber: Int
    
    
    init(category: Category, levelNumber: Int, player: Player)  {
        self.category = category
        self.levelNumber = levelNumber
        self.player = player
        _model = StateObject(wrappedValue: {
            LevelViewModel(words: category.levels[levelNumber], player: player)
        }())

//        _model = StateObject(wrappedValue: {
//            let cateogry = Bundle.main.decode(Category.self, from: "Animals.json")
//            return LevelViewModel(words: cateogry.levels[0])
//        }())
    }
    
    var body: some View {
        VStack {
            VStack {
                ForEach(model.answers) { answer in
                    HStack {
                        if answer.isSolved {
                            Text(answer.word.solution)
                        } else {
                            Text(answer.word.hint)
                            Spacer()
                            Image(systemName: answer.imageName)
                        }
                    }
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    if #available(iOS 16.0, *) {
//                        .bold(answer.isSolved)
//                    }
                    Spacer()
                }
            }
            
            Text(model.currentAnswer)
                .font(.title)
                .lineLimit(1)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.quaternary)
                .cornerRadius(5)
                .overlay(alignment: .leading) {
                    if model.selectedSegments.isEmpty {
                        Text("Score: \(player.score)")
                            .offset(x: 10)
                            .foregroundColor(.secondary)
                    }
                }
                .overlay(alignment: .trailing) {
                    Button(action: model.delete) {
                        Label("Delete", systemImage: "delete.left")
                            .font(.title)
                            .labelStyle(.iconOnly)
                    }
                    .buttonStyle(.plain)
                    .offset(x: -10)
                }
                .overlay(alignment: .center) {
                    if model.playAnimation == true {
                        Text("You Won!")
                            .font(.title)
                    }
                }
            
            Spacer()
            
            LazyVGrid(columns: Array<GridItem>(repeating: .init(.flexible()), count: 4)) {
                ForEach(0..<model.segments.count, id: \.self) { index in
                    let segment = model.segments[index]
                    
                    Button {
                        model.select(index)
                    } label: {
                        SegmentView(segment: segment)
                    }
                    .buttonStyle(.plain)
                    .disabled(segment.isUsed)
                    .disabled(model.selectedSegments.count == 7)
                }
            }
        }
        .padding()
        .confettiCannon(counter: $model.counter)
        .navigationTitle("Level \(levelNumber + 1)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(category: .example, levelNumber: 0, player: Player())
    }
}

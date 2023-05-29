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

    @State var hint: String = ""
    
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
                            Button {
                                 showHint(answer.word)
                            } label: {
                                Image(systemName: answer.imageName)
                            }
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
                        hint = ""
                        model.select(index)
                    } label: {
                        SegmentView(segment: segment, hint: $hint)
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
    
    func showHint(_ word: Word) {
        print("CurrentAnswer count: \(model.currentAnswer)")
        print("Current word segements count: \(word.segments.count)")
        if model.selectedSegments.isEmpty {
            if word.segments.count >= 1 {
                hint = word.segments[0]
                print(word.segments[0])
            }
        } else if model.currentAnswer.count == 3 {
            print("Debug: 1 segment already selected.")
            if word.segments.count >= 2 {
                hint = word.segments[1]
                print(word.segments[1])
            }
        } else if model.currentAnswer.count == 6 {
            print("Debug: 2 segments already selected.")
            if word.segments.count >= 3 {
                hint = word.segments[2]
                print(word.segments[2])
            }
        } else {
            print(model.currentAnswer)
            print("You really need more hints?")
        }
        print("Hint: \(hint)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(category: .example, levelNumber: 0, player: Player())
    }
}

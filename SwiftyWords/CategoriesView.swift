//
//  CategoriesView.swift
//  SwiftyWords
//
//  Created by Hans Cathcart on 4/22/23.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var player: Player = Player()

    var categories = Bundle.main.decode([String].self, from: "Categories.json").map {
        Bundle.main.decode(Category.self, from: "\($0).json")
    }
        
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                List(categories) { category in
                    NavigationLink(value: category) {
                        VStack(alignment: .leading) {
                            Text(category.name)
                                .font(.headline)
                            Text(category.description)
                        }
                    }
                }
                .navigationTitle("7 swiftyWords")
                .navigationDestination(for: Category.self) {
                    category in
                    LevelsView(category: category, player: player)
                }
                ScoreView(player: player)
            }
        } else {
            NavigationView {
                List(categories) { category in
                        VStack(alignment: .leading) {
                            Text(category.name)
                                .font(.headline)
                            Text(category.description)
                    }
                }
                .navigationTitle("7 swiftyWords")
                ScoreView(player: player)
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}

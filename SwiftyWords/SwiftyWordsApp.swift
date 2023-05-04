//
//  SwiftyWordsApp.swift
//  SwiftyWords
//
//  Created by Hans Cathcart on 4/22/23.
//

import SwiftUI

@main
struct SwiftyWordsApp: App {
    init() {
        UserDefaults.standard.register(defaults: [
            "score": 0
        ])
    }

    var body: some Scene {
        WindowGroup {
            CategoriesView()
        }
    }
}


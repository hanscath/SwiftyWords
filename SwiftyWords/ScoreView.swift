//
//  ScoreView.swift
//  SwiftyWords
//
//  Created by Hans Cathcart on 4/23/23.
//

import SwiftUI

struct ScoreView: View {
    @ObservedObject var player: Player

    var body: some View {
        Text("Score: \(player.score)")
            .font(.headline)
            .padding(.top)
            .frame(maxWidth: .infinity)
            .background(.green)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(player: Player())
    }
}

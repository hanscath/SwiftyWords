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
        HStack {
            Text("Score: \(player.score)")
            Spacer()
            NavigationLink("Confetti") {
                ConfettiTest()
            }
            .foregroundColor(.white)
            
        }
        .font(.title2)
        .padding(.top, 5)
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .frame(maxWidth: .infinity)
        .background(.green)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScoreView(player: Player())
        }
    }
}

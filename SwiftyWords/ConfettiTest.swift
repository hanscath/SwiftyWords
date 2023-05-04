//
//  ConfettiTest.swift
//  SwiftyWords
//
//  Created by Hans Cathcart on 4/23/23.
//

// From:
// https://www.appcoda.com/swiftui-confetti-animation/

import SwiftUI
import ConfettiSwiftUI

struct ConfettiTest: View {
    @State private var counter = 0

    var body: some View {
        Button(action: {
            counter += 1
        }) {
            Text("🎃")
                .font(.system(size: 50))
        }
        .confettiCannon(counter: $counter)
        .onAppear {
            counter += 1
        }
    }

}
struct ConfettiTest_Previews: PreviewProvider {
    static var previews: some View {
        ConfettiTest()
    }
}

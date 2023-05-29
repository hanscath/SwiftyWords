//
//  SegmentView.swift
//  SwiftyWords
//
//  Created by Hans Cathcart on 4/22/23.
//

import SwiftUI

struct SegmentView: View {
    var segment: Segment
    @Binding var hint: String
    
//    init(segment: Segment, hint: String) {
//        self.segment = segment
//        self.hint = hint
//        print(segment)
//    }
    
    var body: some View {
        Text(segment.text)
            .opacity(segment.isUsed ? 0 : 1)
            .font(.title3)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(segment.text == hint ? .pink : .indigo)
            .cornerRadius(5)
    }
}

struct SegmentView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentView(segment: .example, hint: .constant("ABC"))
    }
}

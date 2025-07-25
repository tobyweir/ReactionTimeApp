//
//  DayView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

import SwiftUI

struct DayView: View {
    let date: Int
    let results: [Result]
    var body: some View {
        ZStack {
            Rectangle()
                .aspectRatio(1/2 , contentMode: .fit)
                .foregroundStyle(.white)
            VStack {
                dateNumber
                Spacer()
            }
        }
    }

    var dateNumber: some View {
        Text("\(date)")
            .foregroundStyle(.black)
            .font(.largeTitle).bold()
    }
}

#Preview {
    DayView(date: 1, results: [])
}

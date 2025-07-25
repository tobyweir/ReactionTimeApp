//
//  WeekView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//
import SwiftUI

struct WeekView: View {
    let dates: [Int]
    let results: [[Result]]
    var body: some View {
        HStack (spacing: 0){
            ForEach(0..<7) { index in
                if (dates.count == 7 && results.count == 7) {
                    DayView(date: dates[index], results: results[index])
                }

            }

        }
        .border(.black)
    }
}

#Preview {
    WeekView(dates: [1,2,3,4,5,6,7], results: [[Result(average: 0.8)],[],[],[],[],[],[]])
}

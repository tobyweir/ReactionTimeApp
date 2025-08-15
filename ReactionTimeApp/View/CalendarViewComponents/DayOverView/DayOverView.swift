//
//  DayOverView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//
import SwiftUI

struct DayOverView: View {
    let date: Date
    let results: [Result]

    var body: some View {
        Text("day")
    }

}

#Preview {
    
    DayOverView(date: Date.createDummyDate(day: 1, month: 7, year: 2020), results: [])
}

//
//  WeekView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//
import SwiftUI

struct WeekView: View {
    let mondayView: DayView
    let tuesdayView: DayView
    let wednesdayView: DayView
    let thursdayView: DayView
    let fridayView: DayView
    let saturdayView: DayView
    let sundayView: DayView
    let results: [[Result]] = [[]]


    init () {

    }

    var body: some View {
        HStack (spacing: 0){
            mondayView
            tuesdayView
            wednesdayView
            thursdayView
            fridayView
            saturdayView
            sundayView

        }
        .border(.black)
    }
}

#Preview {
    WeekView()
}

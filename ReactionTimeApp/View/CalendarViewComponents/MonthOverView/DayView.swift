//
//  DayView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

import SwiftUI

struct DayView: View {
    var day: Day = .Monday
    var date: Int = -1
    let results: [Result]
    var dayType: CalendarDayType = .weekday
    @Environment(\.colorScheme) var colorScheme

    var foregroundColour: Color {
        if dayType == .weekend {
            Color.gray
        } else {
            colorScheme == .dark ? .white : .black
        }
    }
    var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(backgroundColor)
            VStack (spacing: 0) {
                dateNumber
                resultView

            }
        }.aspectRatio(1/2 , contentMode: .fit)
    }

    var dateNumber: some View {
        Text("\(date)")
            .foregroundStyle(foregroundColour)
            .font(.system(size: 30))
    }

    var resultView: some View {
        Circle()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(resultViewColor)
            .scaleEffect(CGSize(width: 0.75, height: 0.75), anchor: .center)
    }

    var resultViewColor: Color {
        switch results.count {
        case 0:
            backgroundColor
        default:
                .green
        }
    }
}

#Preview {
    DayView(date: 1, results: [Result(average: 1.2)])
}

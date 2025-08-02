//
//  DayView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

import SwiftUI

struct DayView: View {
    var date: Date?
    var dayType: CalendarDayType
    let model: Controller
    @Environment(\.colorScheme) var colorScheme

    init (date: Date?, dayType: CalendarDayType, model : Controller) {
        self.date = date
        self.dayType = dayType
        self.model = model
    }

    var isWeekend: Bool {
        if let tempDate = date {
            Calendar.current.isDateInWeekend(tempDate)
        } else {
            false
        }

    }
    var foregroundColour: Color {
        if isWeekend == true {
            Color.gray
        } else {
            colorScheme == .dark ? .white : .black
        }
    }

    var backgroundColor: Color {
        colorScheme == .dark ? .black : .white
    }

    var results: [Result] {
        if (dayType != .invalid) {
            if let date {
                return model.getResults(between: date, and: date)
            } else { return [] }
        } else {
            return []
        }
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(backgroundColor)
            VStack (spacing: 0) {
                dateNumberView
                resultView

            }
        }.aspectRatio(1/2 , contentMode: .fit)
    }

    @ViewBuilder
    var dateNumberView: some View {
        Text("\(date?.formatted(Date.FormatStyle().day()) ?? "0")")
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
    DayView(date: Date.now.addingTimeInterval(-UsefulTimeIntervals.day.rawValue), dayType: .weekday, model: Controller())
}

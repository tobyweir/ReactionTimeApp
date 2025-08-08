//
//  DayView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

import SwiftUI

struct DayView: View , Identifiable {
    var id = UUID()
    var date: Date?
    var dayType: CalendarDayType
    let model: Controller
    @State var results: [Result] = []
    @State var foregroundColour: Color = .gray
    @State var backgroundColour: Color = .white
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

    @ViewBuilder
    var body: some View {
        if dayType == .invalid {
            invalidView
        } else {
            totalView
        }
    }

    var invalidView : some View {
        Rectangle().foregroundStyle(backgroundColour)
    }

    var totalView : some View {
        ZStack {
            Rectangle()
                .foregroundStyle(backgroundColour)
            contentView
        }.aspectRatio(1/2 , contentMode: .fit)
            .onAppear(perform: initView)
    }

    var contentView: some View {
        VStack (spacing: 0) {
            dateNumberView
            resultView

        }
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(.gray), alignment: .top)
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
            backgroundColour
        default:
                .green
        }
    }

    func initView () {
        populateResults()
        calculateColours()
    }

    func calculateColours(){
        if isWeekend == true {
            foregroundColour = Color.gray
        } else {
            foregroundColour = colorScheme == .dark ? .white : .black
        }
        backgroundColour = colorScheme == .dark ? .black : .white


    }

    func populateResults () {
        if (dayType != .invalid) {
//            results = model.getResults(between: , and: )
        }
    }
}

#Preview {
    DayView(date: Date.now.addingTimeInterval(-UsefulTimeIntervals.day.rawValue), dayType: .weekday, model: Controller())
}

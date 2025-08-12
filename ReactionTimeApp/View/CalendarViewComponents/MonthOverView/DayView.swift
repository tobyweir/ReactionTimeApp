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
    let isWeekend: Bool
    let model: Controller
    let results: [Result]
    @Environment(\.colorScheme) var colorScheme
    
    init (date: Date?, dayType: CalendarDayType, model : Controller) {
        self.date = date
        self.dayType = dayType
        self.model = model
        self.results = []
        var isWeekendResult: Bool
        if let tempDate = date {
            isWeekendResult = Calendar.current.isDateInWeekend(tempDate)
        } else {
            isWeekendResult = false
        }
        self.isWeekend = isWeekendResult
    }
    
    
    var foregroundColour: Color {
        if isWeekend == true {
            Color.gray
        } else {
            colorScheme == .dark ? .white : .black
        }
    }
    
    var backgroundColour: Color {
        colorScheme == .dark ? .black : .white
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
}

#Preview {
    DayView(date: Date.now.addingTimeInterval(-UsefulTimeIntervals.day.rawValue), dayType: .weekday, model: Controller())
}

//
//  WeekView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//
import SwiftUI

struct WeekView: View {
    let startDate: Date
    let model: Controller
    var dayViews: [DayView] = []
    var monthDigits: String

    init(start: Date, model: Controller) {
        self.startDate = start
        self.model = model
        self.monthDigits = start.formatted(Date.FormatStyle().month(.defaultDigits))
        self.dayViews = createDayViews(date: start)

    }
    func createDayViews (date: Date) -> [DayView] {
        var currDate = date
        var views: [DayView] = []
        for index in 0..<7 {
            let result = createDayView(for: Day.getWeekday(from: index), against: currDate)
            views.append(result.0)
            if (result.1 == true) {
                let newDate = currDate.addingTimeInterval(UsefulTimeIntervals.day.rawValue)
                currDate = newDate.formatted(Date.FormatStyle().month(.defaultDigits)) == monthDigits ? newDate : currDate
            }
        }
        return views
    }
    func createDayView (for day: Day , against date: Date) -> (DayView , Bool) {
        let dayToCompare = date.formatted(Date.FormatStyle().weekday(.abbreviated))
        if (day.rawValue == dayToCompare) {
            let dayView = DayView(date: date, dayType: .weekday, model: model)
            return (dayView , true)
        } else {
            return (DayView(date: nil, dayType: .invalid, model: Controller()) , false)
        }
    }
    var body: some View {
        HStack (spacing: 0){
            ForEach(dayViews) { view in
                view
            }
        }
        .border(.black)
    }
}

#Preview {
    var date = DateComponents()
    let startDate = Date.now.addingTimeInterval(-UsefulTimeIntervals.day.rawValue * 6 )
    WeekView(start: startDate , model: Controller())
}


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

    init(start: Date, model: Controller) {
        self.startDate = start
        self.model = model
        self.dayViews = createDayViews(date: start)

    }
    func createDayViews (date: Date) -> [DayView] {
        var currDate = date
        var views: [DayView] = []
        for index in 0..<7 {
            let result = createDayView(for: Day.getWeekday(from: index), against: currDate)
            views.append(result.0)
            if (result.1 == true) {
                currDate = currDate.addingTimeInterval(UsefulTimeIntervals.day.rawValue)
            }
        }
        return views
    }
    func createDayView (for day: Day , against date: Date) -> (DayView , Bool) {
        let dayToCompare = date.formatted(Date.FormatStyle().weekday(.abbreviated))
        if (day.rawValue == dayToCompare) {
            let dayType = day.getDayType()
            let dayView = DayView(date: date, dayType: dayType, model: model)
            return (dayView , true)
        } else {
            return (DayView(date: nil, dayType: .invalid, model: Controller()) , false)
        }
    }
    var body: some View {
        HStack (spacing: 0){
            dayViews[0]
            dayViews[1]
            dayViews[2]
            dayViews[3]
            dayViews[4]
            dayViews[5]
            dayViews[6]
        }
        .border(.black)
    }
}

#Preview {
    let startDate = Date.now
    WeekView(start: Date.now , model: Controller())
}

public extension Date {

    func add(Days days: Double) -> Date {
        let seconds = days * 24 * 60 * 60
        return addingTimeInterval(seconds)
    }

    func remove(Days days: Double) -> Date {
        let seconds = days * 24 * 60 * 60
        return addingTimeInterval(-seconds)
    }
}

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
    let dayViews: [DayView]

    init(start: Date, model: Controller) {
        self.startDate = start
        self.model = model
        self.dayViews = []

    }
    func createDayViews (date: Date) -> [DayView] {
        []
    }
    func createDayView (day: Day , date: Date) -> DayView {
        
    }
    var body: some View {
        HStack (spacing: 0){

        }
        .border(.black)
    }
}

#Preview {
    let startDate = Date.now
    let endDate = startDate.addingTimeInterval(3 * 24 * 60 * 60)
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

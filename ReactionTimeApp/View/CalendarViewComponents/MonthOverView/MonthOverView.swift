//
//  MonthOverView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

import SwiftUI

struct MonthOverView: View {
    let currMonth: Date

    var currMonthString: String {
        currMonth.formatted(Date.FormatStyle().month(.wide))
    }

    var currYearString: String {
        currMonth.formatted(Date.FormatStyle().year(.defaultDigits))
    }
    var body: some View {
        VStack {
            header
            Text("\(currMonthString) +  \(currYearString)")
            Spacer()
        }

    }

    var header: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                Spacer()
                currMonthView
                    .frame(maxHeight: 60)
                weekdayGuideBar
                    .frame(maxHeight: 0)
            }
        }
        .frame(maxHeight: 140)
        .padding(.bottom)

    }

    var weekdayGuideBar: some View {
        let weekdayArray: [String] = ["M" , "T" , "W", "T" , "F" , "S" , "S"]
        return HStack (spacing: 0) {
                ForEach (weekdayArray, id: \.self) { day in
                    ZStack {
                        Color.blue
                        VStack {
                            Spacer()
                            Text("\(day)")
                        }
                    }
                }
        }
    }

    var currMonthView: some View {
        ZStack {
            Color.red
            HStack (spacing: 0) {
                    Text("\(currMonthString)")
                    .font(.system(size: 30, weight: .bold))
                    .padding(7)
                    Spacer()
                }
        }
    }

    var footer: some View {
        Text("")
    }

    var InfiniteMonthViews: some View {
        ScrollView {
} }

    mutating func getPreviousMonth (date: Date) -> Date {
        var myCalender = Calendar.current.date(byAdding: .month, value: 1, to: date)
        return Date.now
    }

    mutating func getNextMoneh (date: Date) -> Date {
        Date.now
    }
}

#Preview {
    MonthOverView(currMonth: Date.now)
}

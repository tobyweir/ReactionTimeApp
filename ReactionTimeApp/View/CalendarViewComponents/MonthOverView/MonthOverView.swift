//
//  MonthOverView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

import SwiftUI

struct MonthOverView: View {
    @State var currMonth: Date

    var currMonthString: String {
        currMonth.formatted(Date.FormatStyle().month(.wide))
    }

    var currYearString: String {
        currMonth.formatted(Date.FormatStyle().year(.defaultDigits))
    }
    var body: some View {
        VStack {
            header
            Text("\(currMonth)")
            Button {
                currMonth = currMonth.getPreviousMonth()
            } label: {
               Text("Back 1 Month")
            }
            Button {
                currMonth = currMonth.getNextMonth()
            } label: {
                Text("Forward 1 Month")
            }

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

}

extension Date {

    static func createDummyDate (day: Int , month: Int, year: Int) -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        return Calendar.current.date(from: components) ?? Date.now
    }

    func getPreviousMonth () -> Date {
       var components = DateComponents()
       let currMonth = getMonthAsInt(from: self)
       let newMonth = currMonth == 1 ? 12 : currMonth - 1
       let newYear = newMonth == 12 ? (getYearAsInt(from: self)) - 1 : getYearAsInt(from: self)
       components.year = newYear
       components.month = newMonth
       components.day = 1
       return Calendar.current.date(from: components) ?? Date.now
   }

    func getNextMonth () -> Date {
        var components = DateComponents()
        let currMonth = getMonthAsInt(from: self)
        let newMonth = currMonth == 12 ? 1 : currMonth + 1
        let newYear = newMonth == 1 ? getYearAsInt(from: self) + 1 : getYearAsInt(from: self)
        components.year = newYear
        components.month = newMonth
        components.day = 1
        return Calendar.current.date(from: components) ?? Date.now
   }

   func getYearAsInt (from date: Date) -> Int {
       let result = date.formatted(Date.FormatStyle().year(.defaultDigits))
       return Int(result)!
   }

   func getMonthAsInt (from date: Date) -> Int {
       let result = date.formatted(Date.FormatStyle().month(.twoDigits))
       return Int(result)!
   }
}

#Preview {
    MonthOverView(currMonth: Date.now)
}

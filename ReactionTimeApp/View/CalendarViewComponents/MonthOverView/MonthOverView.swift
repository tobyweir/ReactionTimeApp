//
//  MonthOverView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

import SwiftUI


struct MonthOverView: View {
    @State var currMonth: Date
    let model: Controller
    @Environment(\.colorScheme) var colorScheme

    var foregroundColor : Color {
        colorScheme == .dark ? .white : .black
    }

    var backgroundColor : Color {
        colorScheme == .dark ? .black : .white
    }

    var currMonthString: String {
        currMonth.formatted(Date.FormatStyle().month(.wide))
    }

    var currYearString: String {
        currMonth.formatted(Date.FormatStyle().year(.defaultDigits))
    }
    var body: some View {
        VStack (spacing: 0) {
            header
            InfiniteMonthView2(monthId: $currMonth, model: model)
                .aspectRatio(1/2, contentMode: .fill)
        }

    }

    var header: some View {
        ZStack {

            VStack {
                Spacer()
                currMonthView
                    .frame(maxHeight: 60)
                weekdayGuideBar
                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(.primary), alignment: .bottom)
                    .frame(maxHeight: 0)
            }
        }
        .frame(minHeight: 200)
        .padding(.bottom)

    }

    var weekdayGuideBar: some View {
        let weekdayArray: [StringWrapper] = [StringWrapper(val: "M") , StringWrapper(val: "T") , StringWrapper(val: "W") , StringWrapper(val: "T") , StringWrapper(val: "F") , StringWrapper(val: "S") , StringWrapper(val: "S")]
        return HStack (spacing: 0) {
            ForEach (weekdayArray) { day in
                    ZStack {
                        backgroundColor
                        VStack {
                            Spacer()
                            Text("\(day.val)")
                        }
                    }
                }
        }
    }

    struct StringWrapper: Identifiable {
        var id = UUID()
        var val: String
    }

    var currMonthView: some View {
        ZStack {
            backgroundColor
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
        Calendar.current.date(byAdding: .month, value: -1, to: self)!
   }

    func getNextMonth () -> Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!

   }

    func getNextWeek () -> Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: self)!
    }

    func getNextDay () -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

   func getYearAsInt (from date: Date) -> Int {
       let result = date.formatted(Date.FormatStyle().year(.defaultDigits))
       return Int(result)!
   }

   func getMonthAsInt (from date: Date) -> Int {
       let result = date.formatted(Date.FormatStyle().month(.twoDigits))
       return Int(result)!
   }

    func getDayAsInt (from date: Date) -> Int {
        let result = date.formatted(Date.FormatStyle().day(.twoDigits))
        return Int(result)!
    }
}

#Preview {
    let model = Controller()
    let date = Date.createDummyDate(day: 1, month: 8, year: 2025)
    MonthOverView(currMonth: date, model: model)
}

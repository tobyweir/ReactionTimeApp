//
//  CalendarEnums.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

enum CalendarDayType {
    case weekday
    case weekend
    case invalid
}

enum Day {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}
enum Month {
    case January
    case Febuary
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December

    static func getDaysInMonth (month: Month, year: Int) -> Int    {
        switch (month) {
        case .Febuary:
            isALeapYear(year: year) ? 29 : 28
        case .September, .November, .April, .June:
            30
        default:
            31
        }
    }

    static func isALeapYear (year: Int) -> Bool {
        if (year % 100 == 0) {
            year % 400 == 0 ? true : false
        } else {
            year % 4 == 0 ? true : false
        }
    }

    static func getDayFromDate (date: Int, month: Month, year: Int) -> Day {
        return .Monday
    }


}

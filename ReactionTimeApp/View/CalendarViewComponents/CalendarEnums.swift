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

enum Day: Int {
    case Monday = 1
    case Tuesday = 2
    case Wednesday = 3
    case Thursday = 4
    case Friday = 5
    case Saturday = 6
    case Sunday = 0
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

    static func getDaysIn (_ month: Month, year: Int) -> Int    {
        switch (month) {
        case .Febuary:
            isALeapYear(year: year) ? 29 : 28
        case .September, .November, .April, .June:
            30
        default:
            31
        }
    }

    static func getCode (for month: Month) -> Int {
        switch (month) {
        case .January:
            0
        case .Febuary , .March:
            3
        case .April:
            6
        case .May:
            1
        case .June:
            4
        case .July:
            6
        case .August:
            2
        case .September:
            5
        case . October:
            0
        case .November:
            3
        case .December:
            5
        }
    }

}

func isALeapYear (year: Int) -> Bool {
    if (year % 100 == 0) {
        year % 400 == 0 ? true : false
    } else {
        year % 4 == 0 ? true : false
    }
}

func getCenturyCode(for year : Int) -> Int {
    if (year < 0) { return -1}  // Negative years don't exist, unexpected behaviour
    let codes = [4,2,0,6,4,2,0,6,4,2,0,6] // Sliding window , values are 4,2,0,6
    let century = (year / 100) * 100 // remove last 2 digits from the year
    let anchorYear = 1700
    let steps = ((century - anchorYear) / 100) % 4
    let index = 4
    return codes[index + steps]
}

func getDayFromDateGregorianCalendar (date: Int, month: Month, year: Int) -> Day {
    let yearFinal2Digits = year % 100 //last 2 digits of the year
    let yearCode = ( yearFinal2Digits + (yearFinal2Digits / 4)) % 7
    let monthCode = Month.getCode(for: month)
    let centuryCode = getCenturyCode(for: year)
    let leapYearModifier: Int = isALeapYear(year: year) && (month == .January || month == .Febuary) ?  1 :  0
    let dateCode: Int = (yearCode + monthCode + centuryCode + date + leapYearModifier) % 7
    if let day = Day(rawValue: dateCode) {
        return day
    }
    return .Monday
}

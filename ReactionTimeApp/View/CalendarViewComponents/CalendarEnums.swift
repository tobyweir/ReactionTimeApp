//
//  CalendarEnums.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/07/2025.
//

enum CalendarDayType {
    case weekday
    case invalid
}

enum UsefulTimeIntervals : Double {
    case day = 86400
    case hour = 3600

}


enum Day: String {
    case Monday = "Mon"
    case Tuesday = "Tue"
    case Wednesday = "Wed"
    case Thursday = "Thu"
    case Friday = "Fri"
    case Saturday = "Sat"
    case Sunday = "Sun"

    static func getWeekday(from num: Int) -> Day {
        switch (num) {
        case 0:
                .Monday
        case 1:
                .Tuesday
        case 2:
                .Wednesday
        case 3:
                .Thursday
        case 4:
                .Friday
        case 5:
                .Saturday
        case 6:
                .Sunday
        default:
                .Monday
        }
    }
}

//enum Month {
//    case January
//    case Febuary
//    case March
//    case April
//    case May
//    case June
//    case July
//    case August
//    case September
//    case October
//    case November
//    case December
//
//    static func getDaysIn (_ month: Month, year: Int) -> Int    {
//        switch (month) {
//        case .Febuary:
//            isALeapYear(year: year) ? 29 : 28
//        case .September, .November, .April, .June:
//            30
//        default:
//            31
//        }
//    }
//
//    static func getCode (for month: Month) -> Int {
//        switch (month) {
//        case .January:
//            0
//        case .Febuary , .March:
//            3
//        case .April:
//            6
//        case .May:
//            1
//        case .June:
//            4
//        case .July:
//            6
//        case .August:
//            2
//        case .September:
//            5
//        case . October:
//            0
//        case .November:
//            3
//        case .December:
//            5
//        }
//    }
//
//}
//
//func isALeapYear (year: Int) -> Bool {
//    if (year % 100 == 0) {
//        year % 400 == 0 ? true : false
//    } else {
//        year % 4 == 0 ? true : false
//    }
//}



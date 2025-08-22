//
//  ChartData.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 22/08/2025.
//
import Foundation

struct ChartData {
    let model: Controller

    func buildSimpleData(startDate: Date, dateStride: ChartDateValues, keyNumber count: Int , resultType : ResultValueType) -> [SimpleResultData] {
        var results: [SimpleResultData] = []
        var currDate = startDate
        for _ in 0..<count {
            let tempResults = getResultsFor(value: dateStride, date: currDate)

        }

        return results
    }

    func getResultsFor(value: ChartDateValues, date: Date) -> [Result] {
        switch (value) {
        case .day:
            model.resultStore.getResults(on: date)
        case .week:
            model.resultStore.getResultsInWeek(start: date)
        case .month:
            model.resultStore.getResultsIn(month: date)
        case.year:
            model.resultStore.getResultsIn(year: date)
        }
    }

    func incrementDateBy(stride: ChartDateValues, date: Date) -> Date {
        switch(stride) {
        case .day:
            date.getNextDay()
        case .week:
            date.getNextWeek()
        case .month:
            date.getNextMonth()
        case .year:
            date.getNextYear()
        }
    }

    func calcDataResult(on results: [Result], dataType: ResultValueType) -> Double? {
        switch (dataType){
        case .mean:
            calcMean(on: results)
        case .median:
            calcMedian(on: results)
        case .mode:
            calcMode(on: results)
        case .min:
            results.min(by: {$0.time < $1.time})?.time
        case .max:
            results.max(by: {$0.time < $1.time})?.time
        }
    }

    func calcMean(on results: [Result]) -> Double {
        0
    }

    func calcMode(on results: [Result]) -> Double {
        0
    }

    func calcMedian(on results: [Result]) -> Double {
        0
    }

}

struct SimpleResultData: Identifiable, Equatable {
    let id = UUID()
    let type: String
    let value: Double
}

enum ChartDateValues {
    case day, week, month, year
}

enum ResultValueType {
    case max, min , mean , median , mode
}

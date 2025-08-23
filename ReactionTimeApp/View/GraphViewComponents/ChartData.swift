//
//  ChartData.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 22/08/2025.
//
import Foundation

struct ChartData {
    let model: Controller

    func buildSimpleData(startDate: Date, dateStride: ChartDateValues, count: Int , resultType : ResultValueType) -> [SimpleResultData] {
        var data: [SimpleResultData] = []
        var currDate = startDate
        for _ in 0..<count {
            let tempResults = getResultsFor(value: dateStride, date: currDate)
            if (tempResults.count > 1) {
                print("Found values in building data")
                let value = calcDataResult(on: tempResults, dataType: resultType)
                data.append(SimpleResultData(date: currDate, value: value))
            } else {
                print ("no values found")
            }
            currDate = incrementDateBy(stride: dateStride, date: currDate)
        }

        return data
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

    func calcDataResult(on results: [Result], dataType: ResultValueType) -> Int {
        switch (dataType){
        case .mean:
            calcMean(on: results)
        case .median:
            calcMedian(on: results)
        case .mode:
            calcMode(on: results)
        case .min:
            Int (results.min(by: {$0.time < $1.time})!.time * 1000)
        case .max:
            Int (results.max(by: {$0.time < $1.time})!.time * 1000)
        }
    }

    func calcMean(on results: [Result]) -> Int {
        var runningTotal: Double = 0
        for result in results {
            runningTotal += result.time
        }
        return Int((runningTotal / Double(results.count)) * 1000)
    }

    func calcMode(on results: [Result]) -> Int {
        var counts: [Double: Int] = [:]
        results.forEach { counts[$0.time] = counts[$0.time] ?? 0 + 1}
        if let highestCount = counts.max(by: {$0.value < $1.value})?.value {
            return Int((counts.compactMap{ $0.value == highestCount ? $0.key : nil})[0] * 1000)
        } else {
            return 0
        }
    }

    func calcMedian(on results: [Result]) -> Int {
        let sortedResults = results.sorted(by: {$0.time < $1.time})
        let count = sortedResults.count
        if count % 2 == 0 {
            let resultsToAverage = [sortedResults[count / 2], sortedResults[count / 2 - 1]]
            return calcMedian(on: resultsToAverage)
        } else {
            return Int(sortedResults[count / 2].time * 1000)
        }
    }

}

struct SimpleResultData: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let value: Int
}

enum ChartDateValues {
    case day, week, month, year
}

enum ResultValueType {
    case max, min , mean , median , mode
}

//
//  ChartData.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 22/08/2025.
//
import Foundation
import Charts

struct ChartData {
    let model: Controller

    func getResultData(type: ResultValueType, from startDate: Date, to endDate: Date = Date.now) -> [SimpleResultData] {
        var data: [SimpleResultData] = []
        var resultDictionary: [String : [Result]] = [:]
        for result in model.resultStore.results {
            if (result.dateRecorded > startDate && result.dateRecorded < endDate) {
                let resultDateString = result.dateRecorded.formatted(Date.FormatStyle().day().month().year())
                resultDictionary[resultDateString] = (resultDictionary[resultDateString] ?? []) + [result]
            }
        }
        for element in resultDictionary {
            if (element.value.count > 4) {
                let firstDate = element.value[0].dateRecorded
                let date = Date.createDummyDate(day: firstDate.getDayAsInt(), month: firstDate.getMonthAsInt(), year: firstDate.getYearAsInt())
                let resultData = SimpleResultData(type: type , results: element.value, date: date)
                data.append(resultData)
            }

        }
        return data.sorted(by: {$0.date < $1.date})
    }

    func addFakeData() {
        for _ in 0..<Int.random(in: 10..<50) {
            let day = Int.random(in: 1..<28)
            let month = Int.random(in: 1..<13)
            let year = Int.random(in: 2000..<2025)
            let date = Date.createDummyDate(day: day, month: month, year: year)
            for _ in 10..<25 {
                let time = Double.random(in: 0.150..<0.500)
                model.resultStore.add(Result(time: time, dateRecorded: date))
            }
        }
    }

    static func calcMean(on results: [Result]) -> Int {
        var runningTotal: Double = 0
        for result in results {
            runningTotal += result.time
        }
        return Int((runningTotal / Double(results.count)) * 1000)
    }

    static func calcMode(on results: [Result]) -> Int {
        var counts: [Double: Int] = [:]
        results.forEach { counts[$0.time] = counts[$0.time] ?? 0 + 1}
        if let highestCount = counts.max(by: {$0.value < $1.value})?.value {
            return Int((counts.compactMap{ $0.value == highestCount ? $0.key : nil})[0] * 1000)
        } else {
            return 0
        }
    }

    static func calcMedian(on results: [Result]) -> Int {
        let sortedResults = results.sorted(by: {$0.time < $1.time})
        let count = sortedResults.count
        if count % 2 == 0 {
            let resultsToAverage = [sortedResults[count / 2], sortedResults[count / 2 - 1]]
            return calcMean(on: resultsToAverage)
        } else {
            return Int(sortedResults[count / 2].time * 1000)
        }
    }

}

struct SimpleResultData: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let type: ResultValueType
    let value: Int

    init (type: ResultValueType ,results: [Result], date: Date) {
        self.date = date
        self.type = type
        var tempValue = 1
        switch (type) {
        case .mean :
            tempValue = ChartData.calcMean(on: results)
        case .mode:
            tempValue = ChartData.calcMode(on: results)
        case .median:
            tempValue = ChartData.calcMedian(on: results)
        case .min:
            tempValue = Int(results.min(by: {$0.time < $1.time})! .time * 1000)
        case .max:
            tempValue = Int(results.max(by: {$0.time < $1.time})!.time * 1000)
        }
        self.value = tempValue
    }
}

enum ChartDateValues {
    case day, week, month, year
}

enum ResultValueType: String {
    case max = "max"
    case min = "min"
    case mean = "mean"
    case median = "median"
    case mode = "mode"
}

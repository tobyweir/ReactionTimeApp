//
//  ChartData.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 22/08/2025.
//
import Foundation

struct ChartData {
    let model: Controller

    func buildSimpleData(dateStride: ChartDateValues, keyNumber count: Int , resultType : ResultValueType) -> [SimpleResultData] {
        var result: [SimpleResultData] = []

        return result
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

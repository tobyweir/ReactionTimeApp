//
//  GraphView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 22/08/2025.
//

import SwiftUI
import Charts


struct GraphView: View {
    let model: Controller
    let dataModel: ChartData
    @State var data: [SimpleResultData] = []

    init(model: Controller) {
        self.model = model
        self.dataModel = ChartData(model: model)
    }

    @State var startDate: Date = Date.createDummyDate(day: 1, month: 8, year: 2025)
    @State var endDate: Date = Date.now
    @State var stride: ChartDateValues = .month
    @State var count: Int = 6


    var body: some View {
        Text("\(data.count)")
        Chart {
            ForEach(data) { dataPoint in
                BarMark(x: .value("Date", dataPoint.date),
                         y: .value("Time", dataPoint.value))
            }
        }
        .chartXScale(domain: Date.createDummyDate(day: 1, month: 1, year: 2024)...Date.createDummyDate(day: 1, month: 1, year: 2026))
        .aspectRatio(1 ,contentMode: .fit)
        .onAppear {
            data = dataModel.buildSimpleData(startDate: startDate, dateStride: .month, count: 30, resultType: .min)
        }
        .padding()
    }

}

struct SimpleData: Identifiable, Equatable {
    let date: Date
    let count: Int
    let id = UUID()
}

#Preview {
    let model = Controller()
    GraphView(model: model)
}

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
//    @State var totalData: [(type: ResultValueType, data: [SimpleResultData])] = []
    @State var endDate: Date = Date.now
    @State var startDate : Date = Date.now.getPreviousMonth()


    var finalData: [(type: ResultValueType, data: [SimpleResultData])] {
        var totalData: [(type: ResultValueType, data: [SimpleResultData])] = []
        totalData.append((.mean , dataModel.getResultData(type: .mean, from: startDate, to: endDate)))
        totalData.append((.mode , dataModel.getResultData(type: .mode, from: startDate, to: endDate)))
        totalData.append((.median , dataModel.getResultData(type: .median, from: startDate, to: endDate)))
        totalData.append((.max , dataModel.getResultData(type: .max, from: startDate, to: endDate)))
        totalData.append((.min , dataModel.getResultData(type: .min, from: startDate, to: endDate)))
        return totalData
    }
    @State var displayMaxData: Bool = false
    @State var displayMinData: Bool = false
    @State var displayMeanData: Bool = true
    @State var displayMedianData: Bool = false
    @State var displayModeData: Bool = false

    let meanColor: Color = .green
    let modeColor: Color = .red
    let medianColor: Color = .yellow
    let minColor: Color = .pink
    let maxColor: Color = .cyan

    init(model: Controller) {
        self.model = model
        self.dataModel = ChartData(model: model)
    }


    var body: some View {
        VStack{
            Spacer()
            dateSelectors
            chartView
            dataTypeSelectors
                .padding(.top)
            Spacer()
        }.padding()
    }

    var dataTypeSelectors: some View {
        VStack {
            HStack {
                Toggle(isOn: $displayMeanData) {
                    Label("Mean" , systemImage: "")
                }
                .toggleStyle(.button)
                .tint(.blue)
                Toggle(isOn: $displayModeData) {
                    Label("Mode" , systemImage: "")
                }
                .toggleStyle(.button)
                .tint(.green)
                Toggle(isOn: $displayMedianData) {
                    Label("Median" , systemImage: "")
                }
                .toggleStyle(.button)
                .tint(.orange)
            }
            HStack {
                Toggle(isOn: $displayMaxData) {
                    Label("Max" , systemImage: "")
                }
                .toggleStyle(.button)
                .tint(.purple)
                Toggle(isOn: $displayMinData) {
                    Label("Min" , systemImage: "")
                }
                .toggleStyle(.button)
                .tint(.red)
            }
        }
    }

    var dateSelectors: some View {
        HStack (spacing: 0){

            startDatePicker
//                .frame(maxWidth: 200)
            Spacer()
            endDatePicker
//                .frame(maxWidth: 200)
        }
    }

    var startDatePicker: some View {
        let closedDateRange = Date.createDummyDate(day: 1, month: 1, year: 10)...endDate.getPreviousDay()
        return DatePicker ("From:", selection: $startDate, in: closedDateRange, displayedComponents: [.date])
    }

    var endDatePicker: some View {
        let closedDateRange = startDate.getNextDay()...Date.now
        return DatePicker ("To:", selection: $endDate,in: closedDateRange, displayedComponents: [.date])
    }

    var chartView: some View {
        Chart (finalData, id: \.type) { dataSeries in
            ForEach(dataSeries.data) { data in
                if (isTypeSelected(type: dataSeries.type)) {
                    LineMark(x: .value("Date", data.date), y: .value("Time", data.value))
                }
            }
            .foregroundStyle(by: .value("Type", dataSeries.type.rawValue))
            .symbol(by: .value("Type", dataSeries.type.rawValue))

        }
        .chartYAxisLabel("Reaction in ms")
        .chartXScale(domain: startDate...endDate)
        .aspectRatio(1 ,contentMode: .fit)
        .padding()
    }

    func isTypeSelected(type: ResultValueType) -> Bool {
        switch (type) {
        case .max:
            displayMaxData
        case .min:
            displayMinData
        case .mode:
            displayModeData
        case .mean:
            displayMeanData
        case .median:
            displayMedianData
        }
    }

    func typeToColor(type: ResultValueType) -> Color {
        switch (type) {
        case .max:
                .purple
        case .min:
                .red
        case .mode:
                .green
        case .mean:
                .blue
        case .median:
                .yellow
        }
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

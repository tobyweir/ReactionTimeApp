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
    let data = [SimpleData(type: "bird" , count: 2),
                SimpleData(type: "dog", count: 2),
                SimpleData(type: "cat", count: 4)]

    var maxSimpleData: SimpleData? {
        data.max {$0.count < $1.count}
    }

    var body: some View {
        Chart {
            ForEach(data) { dataPoint in
                LineMark(x: .value("Type", dataPoint.type),
                        y: .value("Population", dataPoint.count))
            }
        }
        .aspectRatio(1 ,contentMode: .fit)
        .padding()
    }

}

struct SimpleData: Identifiable, Equatable {
    let type: String
    let count: Int
    let id = UUID()
}

#Preview {
    let model = Controller()
    GraphView(model: model)
}

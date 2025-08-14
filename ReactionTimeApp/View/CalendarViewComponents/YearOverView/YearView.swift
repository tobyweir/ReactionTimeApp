//
//  YearView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//

import SwiftUI

struct YearView: View {
    @Binding var currYear: Int
    let year: Int
    let startDate: Date
    let model: Controller
    @State var currMonth: Date

    init(year: Int, model: Controller, currYear: Binding<Int>) {
        self.year = year
        self._currYear = currYear
        self.startDate = Date.createDummyDate(day: 1, month: 1, year: year)
        self._currMonth = State( initialValue: Date.createDummyDate(day: 1, month: 1, year: year))
        self.model = model
    }

    var body: some View {
            VStack {
                HStack {
                    Text("\(String(year))")
                        .padding(.horizontal, 25)
                        .font(.system(size: 30))
                    Spacer()
                }
                Grid {
                    ForEach(0..<4) { index1 in
                        GridRow {
                            ForEach(1..<4) { index2 in
                                MonthOfYearView(startDate: Date.createDummyDate(day: 1, month: (index1 * 3 + index2), year: year), model: model, year: $currYear)
                            }
                        }
                    }
                }
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(.gray), alignment: .top)
        }
    }

}


struct MonthOfYearView: View {
    let startDate: Date
    let model: Controller
    @Binding var year: Int
    @Environment(\.colorScheme) var colourScheme
    var body: some View {
        NavigationLink (destination: MonthOverView(currMonth: startDate, year: $year, model: model)) {
            ZStack {
                Rectangle()
                    .foregroundStyle(colourScheme == .dark ? .black : .white)
                Circle()
                    .foregroundStyle(.green)
                    .scaleEffect(0.75)
                Text("\(startDate.formatted(Date.FormatStyle().month(.abbreviated)))")
                    .font(.system(size: 20))
                    .foregroundStyle(colourScheme == .dark ? .white : .black)
            }
            .aspectRatio(1 , contentMode: .fit)
        }
    }
}
#Preview {
    @Previewable @State var currYear = 2020
    let model = Controller()
    YearView(year: 2025, model: model , currYear: $currYear)
}

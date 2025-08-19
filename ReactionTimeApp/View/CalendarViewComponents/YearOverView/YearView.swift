//
//  YearView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//

import SwiftUI

struct YearView: View {
//    @Binding var currYear: Int
    @Binding var currDate: Date
    @Binding var currYear: Int
    let year: Int
    let startDate: Date
    let model: Controller

    init(currDate: Binding<Date> , year: Int, model: Controller, currYear: Binding<Int>) {
        self._currDate = currDate
        self.year = year
//        self._currYear = currYear
        self.startDate = Date.createDummyDate(day: 1, month: 1, year: year)
        self.model = model
        self._currYear = currYear
    }

    var body: some View {
            VStack {
                HStack {
                    Text("\(String(year))")
                        .padding(.horizontal, 25)
                        .font(.system(size: 30))
                }
                Grid {
                    ForEach(0..<4) { index1 in
                        GridRow {
                            ForEach(1..<4) { index2 in
                                MonthOfYearView(currDate: $currDate , startDate: Date.createDummyDate(day: 1, month: (index1 * 3 + index2), year: year),currYear: $currYear, model: model)
                            }
                        }
                    }
                }
                .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(.gray), alignment: .top)
        }
    }

}


struct MonthOfYearView: View {
    @Binding var currDate: Date
    @State var navIsActive: Bool = false
    let startDate: Date
    @Binding var currYear: Int
    let model: Controller

    @Environment(\.colorScheme) var colourScheme

    init(currDate: Binding<Date> , startDate: Date, currYear: Binding<Int> , model: Controller) {
        self._currDate = currDate
        self.startDate = startDate
        self._currYear = currYear
        self.model = model
    }

    var resultCount : Int {
        model.getResultsIn(month: startDate).count
    }

    var body: some View {
        NavigationLink(isActive: $navIsActive) {
            MonthOverView(currMonth: $currDate, startDate: startDate, model: model)
        }
        label: {
            ZStack {
                Rectangle()
                    .foregroundStyle(colourScheme == .dark ? .black : .white)
                Circle()
                    .foregroundStyle(.green)

                    .scaleEffect(0.75)
                    .opacity(Result.resultCountToOpacity(resultCount))
                Text("\(startDate.formatted(Date.FormatStyle().month(.abbreviated)))")
                    .font(.system(size: 20))
                    .foregroundStyle(colourScheme == .dark ? .white : .black)
            }
            .aspectRatio(1 , contentMode: .fit)
        }
        .onChange(of: navIsActive) {
            currDate = startDate
        }
    }


    }

#Preview {
//    @Previewable @State var currYear = 2020
//    @Previewable @State var dateTracker = Date.now
//    let model = Controller()
//    YearView(year: 2025, model: model , currYear: $currYear, dateTracker: $dateTracker)
}

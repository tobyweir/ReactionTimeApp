//
//  InfiniteMonthView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 05/08/2025.
//

import SwiftUI

struct InfiniteMonthView: View {
    @State  var months: [Date]
    @Binding var monthId: Date
    let model : Controller

    init (monthId: Binding<Date> , model : Controller ) {
        self._monthId = monthId
        self.model = model
        months = [monthId.wrappedValue]
    }

    var body: some View {
            ScrollView (.vertical , showsIndicators: false){
                LazyVStack {
                    ForEach (months , id: \.self) { month in
                        MonthView(start: month, model: model)
//                            .onAppear {
//                                if (month == months[1]) {
//                                    months.insert(months.first!.getPreviousMonth(), at: 0)
//                                } else if (month == months[months.count - 2]) {
//                                    months.append(months.last!.getNextMonth())
//                                }
//                            }
                    }
                }
                .onAppear(perform: initMonths)
                .scrollTargetLayout()
            }
            .scrollPosition(id: Binding($monthId), anchor: .center)
            .onChange(of: monthId, initial: false) { oldValue, newValue  in
                if (newValue == months[1]) {
                    months.insert(months.first!.getPreviousMonth(), at: 0)
                } else if (newValue == months[months.count - 2]) {
                    months.append(months.last!.getNextMonth())
                }

            }
    }

    func initMonths () {
        expandMonthsUp(by: 3)
        expandMonthsDown(by: 3)
    }

    func expandMonthsUp(by count: Int) {
        for _ in (0..<count) {
            months.insert(months.first!.getPreviousMonth(), at: 0)
        }
    }

    func expandMonthsDown(by count: Int) {
        for _ in (0..<count) {
            months.append(months.last!.getNextMonth())
        }
    }

}

//This second implementation of InfiniteMonthView follows the code found here https://stackoverflow.com/a/78686082
//This seems to improve performance over my original implementation, not 100 percent sure what makes the difference, I think its to do with LazyVStack handling consistent sizes.
//Downside is alot of unused space, especially on a month like febuary.
struct InfiniteMonthView2: View {

    @State var months: [Date] = []
    var model: Controller
    @Binding var currMonth: Date

    init (monthId currMonth : Binding<Date> , model: Controller ) {
        self.months = [currMonth.wrappedValue]
        self._currMonth = currMonth
        self.model = model
    }
    var body: some View {
        GeometryReader { geometryProxy in
            ScrollViewReader { scrollProxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(months, id: \.self) { month in
                            ZStack {
                                Text("\(month)")
                                MonthView(start: month, model: model)
                            }
                            .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)

                            .onAppear {
                                if months[1] == month {
                                    months.insert(months.first!.getPreviousMonth(), at: 0)
                                } else if months[months.count - 2] == month {
                                    months.append(months.last!.getNextMonth())
                                }
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .onAppear {
                    expandMonthsUp(by: 6)
                    expandMonthsDown(by: 6)
                }
                .scrollPosition(id: Binding($currMonth), anchor: .center)
            }
        }
    }

    func expandMonthsUp(by count: Int) {
        for _ in (0..<count) {
            months.insert(months.first!.getPreviousMonth(), at: 0)
        }
    }

    func expandMonthsDown(by count: Int) {
        for _ in (0..<count) {
            months.append(months.last!.getNextMonth())
        }
    }
}

#Preview {
    @Previewable @State var date: Date = Date.createDummyDate(day: 1, month: 8, year: 2025)
    let model = Controller()
    InfiniteMonthView2(monthId: $date, model: model)
}

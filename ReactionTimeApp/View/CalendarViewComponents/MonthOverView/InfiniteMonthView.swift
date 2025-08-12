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
//    @State var loadedToHeadCount: Int = 0

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

#Preview {
    @Previewable @State var date: Date = Date.createDummyDate(day: 1, month: 8, year: 2025)
    let model = Controller()
    InfiniteMonthView(monthId: $date, model: model)
}

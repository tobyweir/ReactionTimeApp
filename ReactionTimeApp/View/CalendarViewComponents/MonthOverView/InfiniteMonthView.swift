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
        VStack {
            ScrollView {
                LazyVStack { //Scrolling lags on Lazy sometimes,may need to swap back
                    ForEach (months , id: \.self) { month in
                        MonthView(start: month, model: model)
                    }
                }
                .onAppear(perform: initMonths)
                .scrollTargetLayout()
            }
            .scrollPosition(id: Binding($monthId))
            .defaultScrollAnchor(.center)
        }
    }

    func initMonths () {
       expandHead()
       expandTail()
    }

    func expandHead () {
        let newHead = months.first
        months = newHead == nil ? months : [newHead!.getPreviousMonth()] + months
    }

    func expandTail () {
        let newTail = months.last
        months = newTail == nil ? months : months + [newTail!.getNextMonth()]
    }

    func reduceHead () {
        if let head = months.indices.first {
            months.remove(at: head)
        }
    }

    func reduceTail () {
        if let tail = months.indices.last {
            months.remove(at: tail)
        }
    }
}

#Preview {
    @Previewable @State var date: Date = Date.createDummyDate(day: 1, month: 8, year: 2025)
    let model = Controller()
    InfiniteMonthView(monthId: $date, model: model)
}

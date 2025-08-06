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
//        Text("\(monthId)")
        ScrollView {
            LazyVStack {
                ForEach (months , id: \.self) { month in
                    MonthView(start: month, model: model)

                }
            }
        }.onAppear(perform: initMonths)

    }

    func initMonths () {
        expandHead()
        expandHead()
        expandTail()
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


struct InfiniteExampleView: View {
    @State var data: [String] = (0 ..< 25).map { String($0) }
    @State var dataID: String?

    var body: some View {
        ScrollView {
            VStack {
                Text("Header")

                LazyVStack {
                    ForEach(data, id: \.self) { item in
                        Color.red
                            .frame(width: 100, height: 100)
                            .overlay {
                                Text("\(item)")
                                    .padding()
                                    .background()
                            }
                    }
                }
                .scrollTargetLayout()
            }
        }
        .scrollPosition(id: $dataID)
        .safeAreaInset(edge: .bottom) {
            HStack {
                Text("\(Text("Scrolled").bold()) \(dataIDText)")
                Spacer()
                Button {
                    dataID = data.first
                } label: {
                    Label("Top", systemImage: "arrow.up")
                }
                Button {
                    dataID = data.last
                } label: {
                    Label("Bottom", systemImage: "arrow.down")
                }
                Menu {

                    Button("Prepend") {
                        let next = String(data.count)
                        data.insert(next, at: 0)
                    }
                    Button("Append") {
                        let next = String(data.count)
                        data.append(next)
                    }
                    Button("Remove First") {
                        data.removeFirst()
                    }
                    Button("Remove Last") {
                        data.removeLast()
                    }

                } label: {
                    Label("More", systemImage: "ellipsis.circle")
                }
            }
        }
    }

    var dataIDText: String {
        dataID.map(String.init(describing:)) ?? "None"
    }
}

#Preview {
    @Previewable @State var date: Date = Date.createDummyDate(day: 1, month: 8, year: 2025)
    let model = Controller()
    InfiniteMonthView(monthId: $date, model: model)
}

//
//  InfiniteYearView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//

import SwiftUI

struct InfiniteYearView: View {
    @Binding var currDate: Date
    @State var arrayInitComplete = false
    @State var years: [Int]
    @State var wasDayOverViewDisplayed = false
    @Binding var currYear: Int
    let model: Controller

    init(currDate: Binding<Date> , currYear: Binding<Int>, model: Controller) {
        self._currDate = currDate
        self.years = [currYear.wrappedValue]
        self._currYear = currYear
        self.model = model
    }

    var body: some View {
        GeometryReader { geometryProxy in
            ScrollViewReader { scrollProxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach (years, id: \.self) { year in
                            YearView(currDate: $currDate , year: year, model: model, currYear: $currYear, dayOverViewStatus: $wasDayOverViewDisplayed)
                                .id(year)
                                .frame(width: geometryProxy.size.width, height: geometryProxy.size.height)
                                .onAppear {
                                    if years[1] == currYear {
                                        expandYearsUp(by: 1)
                                    } else if (years[years.count - 2] == currYear){
                                        expandYearsDown(by: 1)
                                    }
                                }
                        }

                    }
                    .scrollTargetLayout()
                }
                .scrollPosition(id: Binding($currYear), anchor: .center)
                .onAppear {
                    scrollProxy.scrollTo(currDate.getYearAsInt())
                    wasDayOverViewDisplayed = false
                    if (arrayInitComplete == false) {
                        print("expanding years!")
                        expandYearsUp(by: 10)
                        expandYearsDown(by: 10)
                        arrayInitComplete = true
                    }
                }
                .toolbar {
                    Button {
                        let today = Date.now.getYearAsInt()
                        years = [today]
                        expandYearsUp(by: 10)
                        expandYearsDown(by: 10)
                        scrollProxy.scrollTo(today)
                        currYear = today
                    } label: {
                        Text("Today")
                    }
                }
            }
            
        }
    }


    func expandYearsUp(by count: Int) {
        for _ in (0..<count) {
            if (years.first! != 0) {
                years.insert(years.first! - 1, at: 0)
            }
        }
    }

    func expandYearsDown(by count: Int) {
        for _ in (0..<count) {
            years.append(years.last! + 1)
        }
    }
}

//ForEach (years , id: \.self) { year in
//    YearView(year: year, model: model, currYear: $currYear)
//}
#Preview {

}

//
//  InfiniteYearView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//

import SwiftUI

struct InfiniteYearView: View {
    @State var years: [Int]
    @Binding var currYear: Int
    let model: Controller

    init(currYear: Binding<Int>, model: Controller) {
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
                            YearView(year: year, model: model, currYear: $currYear)
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
                .onAppear {
                    expandYearsUp(by: 2000)
                    expandYearsDown(by: 2000)
                }
                .scrollPosition(id: Binding($currYear), anchor: .center)

            }
        }
    }

    func expandYearsDown(by count: Int) {
        for _ in (0..<count) {
            if (years.first! != 0) {
                years.insert(years.first! - 1, at: 0)
            }
        }
    }

    func expandYearsUp(by count: Int) {
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

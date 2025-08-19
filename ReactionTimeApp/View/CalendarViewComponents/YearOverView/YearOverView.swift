//
//  YearOverView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//

import SwiftUI

struct YearOverView: View {
    @State var date: Date = Date.now
    @State var currYear = Date.now.getYearAsInt(from: Date.now)
    let model: Controller
    var body: some View {
        NavigationStack {
            InfiniteYearView(currDate: $date , currYear: $currYear, model: model)
                .navigationTitle(Text("\(String(currYear))"))
//                .toolbar(.hidden , for: .automatic)
        }
        
    }
}

//#Preview {
//    YearOverView(date: Date.createDummyDate(day: 1, month: 8, year: 2025), model: Controller())
//}

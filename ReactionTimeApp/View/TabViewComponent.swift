//
//  TabViewComponent.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/06/2025.
//

import SwiftUI

struct TabViewComponent: View {
    var tabSelectionColor: Color = .blue
    @State var model: Controller
    @State var tabSelection: Int = 1
    var body: some View {

        TabView(selection: $tabSelection) {
            Tab("Calender", systemImage: "calendar", value: 0) {
                MonthView(start: Date.createDummyDate(day: 1, month: 10, year: 2024), model: model)
            }
            Tab("Test", systemImage: "bolt", value: 1) {
                TestView()
            }
            Tab("Graph", systemImage: "chart.bar.xaxis", value: 2) {

            }
            Tab("Profile", systemImage: "person.crop.circle", value: 3) {

            }
        }.tint(tabSelectionColor)

    }


    var testView1: some View {
        Text("TestView1")
    }
}



#Preview {
    let model = Controller()
    TabViewComponent(model: model)
}

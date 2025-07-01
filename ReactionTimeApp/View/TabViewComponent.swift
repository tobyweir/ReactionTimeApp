//
//  TabViewComponent.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/06/2025.
//

import SwiftUI

struct TabViewComponent: View {
    var tabSelectionColor: Color = .blue
    @State var tabSelection: Int = 1
    var body: some View {

        TabView(selection: $tabSelection) {
            Tab("Calender", systemImage: "calendar", value: 0) {
                testView1
            }
            Tab("Test", systemImage: "bolt", value: 1) {
                TimerView()
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
    TabViewComponent()
}

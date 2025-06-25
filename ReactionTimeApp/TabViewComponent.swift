//
//  TabViewComponent.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 25/06/2025.
//

import SwiftUI

struct TabViewComponent: View {
    var body: some View {
        TabView {
            Tab("Calender", systemImage: "calendar") {
                testView1
            }
            Tab("Test", systemImage: "bolt") {

            }
            Tab("Graph", systemImage: "chart.bar.xaxis") {

            }
            Tab("Profile", systemImage: "person.crop.circle") {

            }
        }

    }

    var testView1: some View {
        Text("TestView1")
    }
}



#Preview {
    TabViewComponent()
}

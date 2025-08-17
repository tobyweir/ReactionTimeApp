//
//  ContentView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 23/06/2025.
//

import SwiftUI

struct ContentView: View {
    let model: Controller = Controller()
    var body: some View {
        TabViewComponent(model: model)



    }
}

#Preview {
    ContentView()
}

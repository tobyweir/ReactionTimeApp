//
//  ReactionTimeAppApp.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 23/06/2025.
//

import SwiftUI

@main
struct ReactionTimeAppApp: App {
    var scrollController: UIScrollView = UIScrollView()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UIScrollView.appearance().scrollsToTop = false
                }
        }

    }
}

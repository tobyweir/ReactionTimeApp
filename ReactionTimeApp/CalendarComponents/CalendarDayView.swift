//
//  CalendarDayView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 26/06/2025.
//

import SwiftUI

struct CalendarDayView: View {
    var body: some View {
        ZStack {
            dayViewBackground()
            dayViewDate()

        }
        .aspectRatio(1 , contentMode: .fit)

        }

}

struct dayViewBackground: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(.white)
            .padding(10)
            .background(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.blue)

            }
    }
}

struct dayViewDate: View {
    var body: some View {
        Text("tempDate")
    }
}

struct dayViewResults: View {
    var body: some View {
        Text("tempContents")
    }
}

#Preview {
    CalendarDayView()
}

//
//  CalendarDayView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 26/06/2025.
//

import SwiftUI

struct CalendarDayView: View {
    var dayType: dayType
    var body: some View {
        ZStack {
            dayViewBackground()
            HStack {
                dayViewDate()
                //dayViewResults()
            }
        }
        .aspectRatio(1/3 , contentMode: .fit)

        }

}

private struct dayViewBackground: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(.white)
            .padding(7)
            .background(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.blue)

            }
    }
}

private struct dayViewDate: View {
    var body: some View {
        Text("8")
    }
}

private struct dayViewResults: View {
    var body: some View {
        Text("tempContents")
    }
}

#Preview {
    CalendarDayView(dayType: .weekday)
}

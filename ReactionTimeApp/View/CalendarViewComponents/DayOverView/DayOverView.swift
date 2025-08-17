//
//  DayOverView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//
import SwiftUI

struct DayOverView: View {
    let date: Date
    let model: Controller
    let cornerRadius: CGFloat = 50

    var foregroundColour: Color {
        .red
    }

    var backgroundColour: Color {
        .blue
    }
    var results: [Result] {
        model.getResults(on: date)
    }

    var resultAverage: Double {
        var runnningTotal: Double = 0
        for result in results {
            runnningTotal += result.time
        }
        return runnningTotal / Double (results.count)
    }

    var body: some View {
        mainView
    }

    var mainView: some View {
        VStack{
            header
            if (results.count == 0) {
                Spacer()
                emptyView
                Spacer()
            } else {
                infoBlocks
            }
        }
        .padding(.horizontal)
    }

    var emptyView: some View {
        Text("No results found")
    }

    @ViewBuilder
    var header: some View {
        HStack {
            Text("\(date.formatted(Date.FormatStyle().weekday(.wide).day()).uppercased())")
                .font(.system(size: 15))
                .padding(.horizontal)
            Spacer()
        }
        HStack {
            Text("Summary")
                .padding(.horizontal)
                .font(.system(size: 31))
            Spacer()
        }
    }

    var infoBlocks: some View {
        GeometryReader { proxy in
                VStack {
                    HStack {
                        dayAverageBlock
                            .frame(width: proxy.size.width * 0.55)
                        resultCountBlock
                            .frame(width: proxy.size.width * 0.45)
                    }
                    HStack {
                        animalGradeBlock
                            .frame(width: proxy.size.width * 0.25)
                        bestResultOfTheDayBlock
                            .frame(width: proxy.size.width * 0.75)
                    }
                    HStack {
                        scrollableResultsBlock
                            .frame(width: proxy.size.width, height: proxy.size.height *  0.4)
                    }
                }
        }
    }

    var resultCountBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(backgroundColour)
        }
    }

    var dayAverageBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
        }
    }

    var scrollableResultsBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
            ScrollView  {

            }
        }
    }

    var animalGradeBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(backgroundColour)
            VStack {
                Text("Grade:")
                Spacer()
                Text("\(Result.getAnimalGrade(for: resultAverage))")
                Spacer()
            }
            .padding(.vertical)
        }
    }

    var bestResultOfTheDayBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
        }
    }

    func getAverageResult(for results: [Result]) -> Double {
        var count: Double = 0
        for result in results {
            count += result.time
        }
        return count / Double(results.count)
    }

}

#Preview {
    DayOverView(date: Date.createDummyDate(day: 17, month: 8, year: 2025), model: Controller())
}


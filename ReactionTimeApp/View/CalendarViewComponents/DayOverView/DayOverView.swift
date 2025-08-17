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
    let cornerRadius: CGFloat = 40
    let listColour1: Color = .gray
    let listColour2: Color = .white
    var foregroundColour: Color {
        .gray.opacity(1)
    }

    var backgroundColour: Color {
        .red.opacity(1)
    }
    var results: [Result] {
        model.getResults(on: date)
    }

    var bestResult: Double? {
        results.sorted(by: {$0.time < $1.time}).first?.time
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
                    .padding(.vertical)
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
                .foregroundStyle(foregroundColour)
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
            VStack  {
                HStack {
                    Text("Result count:")
                        .padding(.horizontal)
                        .foregroundStyle(foregroundColour)
                    Spacer()
                }
                Spacer()
                Text("\(results.count)")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.black)
                Spacer()
            }.padding(.vertical)
        }
    }

    var dayAverageBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(backgroundColour)
            VStack {
                HStack {
                    Text("Average:")
                        .foregroundStyle(foregroundColour)
                        .padding(.horizontal)
                    Spacer()
                }
                Spacer()
                Text("\(Int(resultAverage * 1000))ms")
                    .foregroundStyle(.black)
                    .font(.system(size: 30, weight: .bold, design: .rounded))

                Spacer()
            }.padding(.vertical)
        }
    }

    var scrollableResultsBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(backgroundColour)
            resultList
        }
        .padding(10)
    }

    var resultList: some View {
        GeometryReader { proxy in
            Table(results) {
                TableColumn("Result") { result in
                    Text("\(Int (result.time * 1000))ms")
                }
                TableColumn("Time Recorded") { result in
                    Text("\(result.dateRecorded.formatted(Date.FormatStyle().hour().minute()))")
                }
            }
//            .frame(width: proxy.size.width, height: proxy.size.height)
            .scaleEffect(0.85 , anchor: .center)
        }
    }

    struct resultItemView: View {
        let result: Result
        var body: some View {
            HStack {
                Text("\(Int(result.time * 1000))ms")
                    .foregroundStyle(.black)
                Spacer()
                Text("\(result.dateRecorded.formatted(Date.FormatStyle().hour().minute()))")
            }
        }
    }

    var animalGradeBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(backgroundColour)
            VStack {
                Text("Grade:")
                    .foregroundStyle(foregroundColour)
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
                .foregroundStyle(backgroundColour)
            VStack {
                HStack {
                    Text("Best Result:")
                        .foregroundStyle(foregroundColour)
                        .padding(.horizontal)
                    Spacer()
                }
                Spacer()
                Text("\(Int( (bestResult ?? 0.0) * 1000) )ms")
                    .foregroundStyle(.black)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                Spacer()
            }.padding(.vertical)
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


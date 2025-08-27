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
    @Binding var wasdayOverViewDisplayed: Bool
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
        .onAppear {
            wasdayOverViewDisplayed = true
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
                .foregroundStyle(.purple)
            VStack  {
                HStack {
                    Text("Result count:")
                        .padding(.horizontal)
                        .foregroundStyle(.black)
                    Spacer()
                }
                Spacer()
                Text("\(results.count)")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Spacer()
            }.padding(.vertical)
        }
    }

    var dayAverageBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(.yellow)
            VStack {
                HStack {
                    Text("Average:")
                        .foregroundStyle(.black)
                        .padding(.horizontal)
                    Spacer()
                }
                Spacer()
                Text("\(Int(resultAverage * 1000))ms")
                    .foregroundStyle(.white)
                    .font(.system(size: 30, weight: .bold, design: .rounded))

                Spacer()
            }.padding(.vertical)
        }
    }

    var scrollableResultsBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(.mint)
            resultList2
                .scaleEffect(CGSize(width: 0.95, height: 0.95), anchor: .center)
        }
        .padding(10)
    }

    var resultList2: some View {
        List {
            Section (header: HStack {Text("Result").foregroundStyle(.black); Spacer(); Text("Date Recorded").foregroundStyle(.black)}){
                ForEach(Array(results.enumerated()), id: \.offset) { index , result in
                    resultItemView(result: result)
                        .listRowBackground(Rectangle().foregroundColor(index % 2 == 0 ? Color(hex: "#000080") : Color(hex: "#E30B5C")).padding(.vertical, 1))
                        .foregroundStyle(.white)
//                        .swipeActions {
//                            Button(role: .destructive) {
//                                if (results.count > 1) {
//                                    model.resultStore.delete(result)
//                                }
//                            } label: {
//                                Label("Delete", systemImage: "trash.fill")
//                            }
//                        }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .clipped()
                .foregroundStyle(.mint)
        )
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
                Spacer()
                Text("\(result.dateRecorded.formatted(Date.FormatStyle().hour().minute()))")
            }
        }
    }

    var animalGradeBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(.green)
            VStack {
                Text("Grade:")
                    .foregroundStyle(.black)
                Spacer()
                Text("\(Result.getAnimalGrade(for: resultAverage))")
                    .font(.system(size: 40))
                Spacer()
            }
            .padding(.vertical)
        }
    }

    var bestResultOfTheDayBlock: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundStyle(.orange)
            VStack {
                HStack {
                    Text("Best Result:")
                        .foregroundStyle(.black)
                        .padding(.horizontal)
                    Spacer()
                }
                Spacer()
                Text("\(Int( (bestResult ?? 0.0) * 1000) )ms")
                    .foregroundStyle(.white)
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

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    @Previewable @State var um = false
    DayOverView(date: Date.createDummyDate(day: 26, month: 8, year: 2025), model: Controller(), wasdayOverViewDisplayed: $um)
}


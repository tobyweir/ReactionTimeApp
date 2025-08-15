//
//  DayOverView.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 13/08/2025.
//
import SwiftUI

struct DayOverView: View {
    let date: Date
    let results: [Result]
    let animalGrades: [String] = ["🪰" , "🐀" , "🐈" , "🐍" , "🦅" , "🐴" , "🐋", "🦥" , "🪨" ]

    var body: some View {
        VStack {
            Text("\(date)")
            Text("\(results)")
            Text("\(getAnimalGrade(for: getAverageResult(for: results)))")
        }
    }

    func getAnimalGrade(for time: Double) -> String {
        switch (time) {
        case _ where time < 0.02:
            animalGrades[0]
        case _ where time < 0.05:
            animalGrades[1]
        case _ where time < 0.10:
            animalGrades[2]
        case _ where time < 0.20:
            animalGrades[3]
        case _ where time < 0.25:
            animalGrades[4]
        case _ where time < 0.3:
            animalGrades[5]
        case _ where time < 0.35:
            animalGrades[6]
        case _ where time < 0.5:
            animalGrades[7]
        default:
            animalGrades[8]
        }
    }

    func getAverageResult(for results: [Result]) -> Double {
        var count: Double = 0
        for result in results {
            count += result.average
        }
        return count / Double(results.count)
    }

}

#Preview {
    
    DayOverView(date: Date.createDummyDate(day: 1, month: 7, year: 2020), results: [])
}

//
//  Result.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 03/07/2025.
//

import Foundation

//Simple Definition of what a result is,
//To be used by Controller and ResultStore for storage
//And to be displayed by Calendar and Graph views 
struct Result: Codable, Identifiable {
    var id = UUID()
    var time: Double
    var dateRecorded: Date = Date.now


    static func getAnimalGrade(for time: Double) -> String {
        let animalGrades: [String] = ["🪰" , "🐀" , "🐈" , "🐍" , "🦅" , "🐴" , "🐋", "🦥" , "🪨" ]
        switch (time) {
        case _ where time < 0.02:
            return animalGrades[0]
        case _ where time < 0.05:
            return animalGrades[1]
        case _ where time < 0.10:
            return animalGrades[2]
        case _ where time < 0.20:
            return animalGrades[3]
        case _ where time < 0.25:
            return animalGrades[4]
        case _ where time < 0.3:
            return animalGrades[5]
        case _ where time < 0.35:
            return animalGrades[6]
        case _ where time < 0.5:
            return animalGrades[7]
        default:
            return animalGrades[8]
        }
    }

    //for use in view elements to communicate how many results took place on that day/month without using a number
    static func resultCountToOpacity (_ resultCount: Int) -> Double {
        switch (resultCount) {
        case _ where resultCount < 1:
            0
        case _ where resultCount < 10:
            0.35
        case _ where resultCount < 20:
            0.7
        default:
            1
        }
    }
}

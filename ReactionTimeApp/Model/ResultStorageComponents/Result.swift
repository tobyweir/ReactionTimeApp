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
struct Result {
    var id = UUID()
    var average: Double
    var dateRecorded: Date = Date.now
}

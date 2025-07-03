//
//  ResultStore.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 03/07/2025.
//

import Foundation

//Object that mangages the apps Results,
//Will load old results from file system when app is opened
//Will save results to file system as changes are made in the app (e.g a new result is recorded)
//This store will also be responsible for sorting and filtering the results for use by Calendar and Graph views
struct ResultStore {
    var results: [Result]

}

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

    var results: [Result] {
        didSet {
            saveToResultsToFile()
        }
    }
    let storageFilePath: URL = URL.documentsDirectory.appending(path: "ReactionResults")

    init () {
        var resultsFromFile: [Result] = []
        do {
            let data = try Data(contentsOf: storageFilePath)
            resultsFromFile = try JSONDecoder().decode([Result].self, from: data)
        } catch {
            print("Error loading results from file system: \(error)")
        }
        results = resultsFromFile

    }
    //Computed Vars

    var resultCount: Int {
        results.count
    }

    //Adding and Removing results

    mutating func add(_ result: Result) {
        results += [result]
    }

    mutating func delete(_ result: Result) {
        results = results.filter({$0.id != result.id})
    }

    //Returning selections of filtered results

    func getResults(between date: Date , and date2: Date) -> [Result] {
        //Not implemented
        //
        []
    }
    
    //Saving and Loading

    func loadResultsFromFile () -> [Result] {
        do {
            let data = try Data(contentsOf: storageFilePath)
            let results = try JSONDecoder().decode([Result].self, from: data)
            return results
        } catch {
            print("Error loading results from file system: \(error)")
        }
        return []
    }

    func saveToResultsToFile () {
        do {
            let data = try JSONEncoder().encode(results)
            try data.write(to: storageFilePath)
        } catch {
            print("Error saving results to file system: \(error)")
        }
    }
	
}

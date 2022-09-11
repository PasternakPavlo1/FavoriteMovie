//
//  Movies.swift
//  FavoriteList
//
//  Created by Павло Пастернак on 01.09.2022.
//

import Foundation

// MARK: - Movie class
class Movie: Equatable {
    let title: String
    let year: String
    
    // MARK: - Initializations
    init(title: String, year: String) {
        self.title = title
        self.year = year
    }
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        lhs.title == rhs.title &&
        lhs.year == rhs.year
    }
}

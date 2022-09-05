//
//  Movies.swift
//  FavoriteList
//
//  Created by Павло Пастернак on 01.09.2022.
//

import Foundation

// MARK: - Movie class
class Movie {
    let title: String
    let year: String
    
    // MARK: - Initializations
    init(title: String, year: String) {
        self.title = title
        self.year = year
    }
}

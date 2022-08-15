//
//  Movies.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let overview: String
    let posterImageURLPath: String
    let voteAverage: Float
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case releaseDate = "release_date"
        case overview = "overview"
        case posterImageURLPath = "poster_path"
        case voteAverage = "vote_average"
        case imagePath = "backdrop_path"
    }
}


//
//  EndPoint.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import Foundation

extension EndPoint {
    enum API: String {
        case BASE_URL = "https://api.themoviedb.org/3/"
        case IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500/"
        case popular = "movie/popular"
        case language = "&language=en-US"
        case api_key = "?api_key="
        case page = "&page="
    }
}

struct EndPoint {
    func urlStringForMovies(_ page: Int) -> String {
        return "\(API.BASE_URL.rawValue)\(API.popular.rawValue)\(API.api_key.rawValue)\(API_KEY)\(API.language.rawValue)\(API.page.rawValue)\(page)"
    }
    
    func urlStringForImages(_ patch: String) -> String  {
        return "\(API.IMAGE_BASE_URL.rawValue)\(patch)"
    }
}

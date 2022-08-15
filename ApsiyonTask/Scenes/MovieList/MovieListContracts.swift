//
//  MovieListContracts.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import Foundation

protocol MovieViewModelDelegate: AnyObject {
    func moviesDataWillLoad()
    func moviesDataDidLoad()
    func moviesLoaded()
}

protocol ViewModelType {
    func bootstrap()
    func fetchMovies()
    func getMovie(at idx: Int) -> Movie
    var count: Int { get }
   
}

protocol MovieViewModelType: ViewModelType {
    var delegate: MovieViewModelDelegate? { get set }
    init(apiService: APIServiceProtocol)
}

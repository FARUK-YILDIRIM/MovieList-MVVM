//
//  MovieListViewModel.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import UIKit

class MovieListViewModel: MovieViewModelType {
    
    var delegate: MovieViewModelDelegate?
    private let apiService: APIServiceProtocol
   
    required init(apiService: APIServiceProtocol){
        self.apiService = apiService
        bootstrap()
    }
    
    private var limit: Int = 100
    private var currentPage = 0
    
    private var movies = [Movie](){
        didSet {
            if self.count <= limit {
                delegate?.moviesLoaded()
            }
        }
    }
    
    func bootstrap() {
        fetchMovies()
    }
    
    func getMovie(at idx: Int) -> Movie {
        return movies[idx]
    }
    
    var count: Int {
        return movies.count
    }
    
    func loadImage (path: String, completion: @escaping (UIImage?) -> Void) -> Void {
        apiService.loadImage (path) { (result) in
            switch result {
            case .success (let image):
                completion (image)
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }

    func fetchMovies() {
        self.delegate?.moviesDataWillLoad()
        currentPage += 1
        self.apiService.fetchMovies(byPage: currentPage) { (result) in
            switch result {
            case .success(let movie):
                self.movies.append(contentsOf: movie.results)
                self.delegate?.moviesDataDidLoad()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}


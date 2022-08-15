//
//  APIService.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import UIKit
import Alamofire

protocol APIServiceProtocol {
    func fetchMovies(byPage page: Int, completion: @escaping (Result<Movies, Error>) -> Void)
    func loadImage(_ url: String, _ completion: @escaping(Result<UIImage,Error>) -> Void ) -> Void
}

class APIService: APIServiceProtocol  {
    
    fileprivate var endPoint = EndPoint()
    
    func fetchMovies(byPage page: Int, completion: @escaping (Result<Movies, Error>) -> Void) {
        let urlString = endPoint.urlStringForMovies(page)
        handleRequest(urlString: urlString, completion: completion)
    }
    
    private func handleRequest(urlString: String, completion: @escaping (Result<Movies, Error>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseDecodable(of: Movies.self, queue: .main, decoder: JSONDecoder()) { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    private var loadedImages = [String: UIImage]()
    
    func loadImage(_ path: String, _ completion: @escaping(Result<UIImage,Error>) -> Void ) -> Void {
        let urlString = endPoint.urlStringForImages(path)
        
        if let image = loadedImages[urlString] {
            completion(.success(image))
        }
        
        AF.request( urlString, method: .get).response{ response in
            switch response.result {
            case .success(let data):
                if let data = data, let image = UIImage(data: data) {
                    self.loadedImages[urlString] = image
                    completion(.success(image))
                    return
                }
            case .failure(let error):
                guard (error as NSError).code == NSURLErrorCancelled else {
                    completion(.failure(error))
                    return
                }
            }
        }
    }
}


//
//  MovieListViewController.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var viewModel: MovieViewModelType = MovieListViewModel(apiService: APIService())

    lazy var movieListView: MovieListView = {
        let movieListView = MovieListView(viewModel: viewModel as! MovieListViewModel)
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        movieListView.delegate = self
        return movieListView
    }()
    
    var addButton = ApsiyonButton(text: "Add", color: .green, symbol: "plus")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MovieLIST"
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        view.addSubview(movieListView)
        view.addSubview(addButton)
        setupContraints()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            movieListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieListView.topAnchor.constraint(equalTo: view.topAnchor),
            movieListView.bottomAnchor.constraint(equalTo: addButton.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension MovieListViewController: MovieListItemDelegate {
    func selectedMovie(movie: Movie) {
        let viewController = MovieDetailViewController()
        viewController.movie = movie
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

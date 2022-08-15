//
//  MovieListView.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import UIKit

class MovieListView: UIView {

    weak var delegate: MovieListItemDelegate?
    
    var viewModel: MovieListViewModel
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    func setupView() {
        addSubview(tableView)
        addSubview(activityIndicator)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}

//MARK: - UITableViewDataSource
extension MovieListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell
        
        let movie = viewModel.getMovie(at: indexPath.row)
        cell?.titleLabel.text = movie.title
        cell?.yearLabel.text  = splitReleaseDate(movie.releaseDate)
        cell?.scoreLabel.attributedText = voteColor(movie.voteAverage)

        viewModel.loadImage(path: movie.posterImageURLPath) { image in
            DispatchQueue.main.async {
                cell?.movieImage.image = image
            }
        }
        
        return cell ?? UITableViewCell()
    }
}

//MARK: - UITableViewDelegate
extension MovieListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.getMovie(at: indexPath.row)
        delegate?.selectedMovie(movie: movie)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.count - 5 {
            viewModel.fetchMovies()
        }
    }
    
}

//MARK: - MovieViewModelDelegate
extension MovieListView: MovieViewModelDelegate {
    func moviesDataWillLoad() {
        self.activityIndicator.startAnimating()
    }
    
    func moviesDataDidLoad() {
        self.activityIndicator.stopAnimating()
    }
    
    func moviesLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

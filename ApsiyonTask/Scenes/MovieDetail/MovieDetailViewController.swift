//
//  MovieDetailViewController.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
     
        if let movie = movie {
            movieTitle.text = movie.title
        }
        
        setupView()
    }
    
    func setupView() {
        view.addSubview(movieTitle)
        setupContraints()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            movieTitle.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            movieTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

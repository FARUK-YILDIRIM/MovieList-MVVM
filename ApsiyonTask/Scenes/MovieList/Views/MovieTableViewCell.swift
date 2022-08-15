//
//  MovieTableViewCell.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 3
        return stackView
    }()
    
    lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    func makeLabel(size: CGFloat? = 15, color: UIColor? = .systemGray, numberOfLines: Int = 0, bold: Bool = false) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = color!
        label.font = bold == true ? UIFont.boldSystemFont(ofSize: size!) : UIFont.systemFont(ofSize: size!)
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    lazy var titleLabel = makeLabel(size: 18, color: .black, numberOfLines: 2, bold: true)
    lazy var yearLabel  = makeLabel(size: 14, color: .systemGray)
    lazy var scoreLabel = makeLabel(size: 13, bold: true)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(movieImage)
        addSubview(titleLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(yearLabel)
        stackView.addArrangedSubview(scoreLabel)

        setupContraints()
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
         movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
         movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
         movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
         movieImage.heightAnchor.constraint(equalToConstant: 120),
         movieImage.widthAnchor.constraint(equalToConstant: 120)
        ])
    
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: movieImage.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -15),
        ])
        
       NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: movieImage.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
 
        ])
    }
}

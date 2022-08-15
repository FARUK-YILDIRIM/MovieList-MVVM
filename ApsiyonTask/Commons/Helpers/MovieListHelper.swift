//
//  MovieListHelper.swift
//  ApsiyonTask
//
//  Created by Faruk YILDIRIM on 15.08.2022.
//

import UIKit

func splitReleaseDate(_ date: String) -> String {
    let year = date.split(separator: "-")
    return String(year[0])
}

func voteColor(_ vote: Float) -> NSMutableAttributedString {
    var color = UIColor()
    
    switch vote {
    case 0...6.9:
        color = UIColor.red
    case 7.0...8.9:
        color = UIColor.orange
    default:
        color = UIColor.green
    }
    
    let imageAttachment = NSTextAttachment()
    imageAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(color).withConfiguration(UIImage.SymbolConfiguration(pointSize: 13))

    let attributedStringColor = [NSAttributedString.Key.foregroundColor : color];

    let fullString = NSMutableAttributedString(string: "")
    fullString.append(NSAttributedString(attachment: imageAttachment))
    fullString.append(NSAttributedString(string: String(" \(vote) / 10"), attributes: attributedStringColor))

    return fullString
}


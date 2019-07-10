//
//  NewsFeedTableViewCell.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    lazy var feedImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    lazy var feedTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1 // added 1 line so we get the ... encoraging people to tap the cell
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.colourStringWitHex(hexColour: "#DAE0E2", withAlpha: 1)
        
        return view
    }()

    override func layoutSubviews() {
        
        self.contentView.addSubview(feedImage)
        feedImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        feedImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15).isActive = true
        feedImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        feedImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
        self.contentView.addSubview(feedTitle)
        feedTitle.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor).isActive = true
        feedTitle.trailingAnchor.constraint(equalTo: feedImage.trailingAnchor).isActive = true
        feedTitle.topAnchor.constraint(equalTo: feedImage.bottomAnchor, constant: 15).isActive = true
        
        self.contentView.addSubview(divider)
        divider.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        divider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

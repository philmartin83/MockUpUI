//
//  NewsFeedTableViewCell.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell, TableViewCellProtocol, CellDataProtocol {
    // set our allias for the class
    typealias T = Feed
    
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(feedImage)
        contentView.addSubview(feedTitle)
        contentView.addSubview(divider)
        layoutTableViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTableViewCell()
    }
    
    func layoutTableViewCell() {
       
        feedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        feedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        feedImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        feedImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
   
        feedTitle.leadingAnchor.constraint(equalTo: feedImage.leadingAnchor).isActive = true
        feedTitle.trailingAnchor.constraint(equalTo: feedImage.trailingAnchor).isActive = true
        feedTitle.topAnchor.constraint(equalTo: feedImage.bottomAnchor, constant: 15).isActive = true

        divider.topAnchor.constraint(equalTo: feedTitle.bottomAnchor, constant: 15).isActive = true
        divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCellData(data: Feed?) {
        feedTitle.text = data?.title
        feedImage.image = UIImage().base64Decode(strBase64: data?.image)
    }

}

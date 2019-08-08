//
//  PrivacyListRowView.swift
//  MockUpUI
//
//  Created by Phil Martin on 08/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class PrivacyListRowView: UIView{
    
    var icon: UIImageView = {
        let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: titleFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: boldFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupRowWithData(title: String, icon: UIImage, subtitle: String) {
        
    }
}

//
//  PrivacySettings.swift
//  MockUpUI
//
//  Created by Phil Martin on 08/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class PrivacySettings{
    var title: String?
    var icon: UIImage?
    var subtitle: String?
    
    init(title: String, icon: UIImage, subtitle: String) {
        self.title = title
        self.icon = icon
        self.subtitle = subtitle
    }
}

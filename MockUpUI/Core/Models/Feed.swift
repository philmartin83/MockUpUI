//
//  Feed.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation

struct Feed: Codable{
    let title: String?
    let body: String?
    let image: String? // the image normally would be a URL but for demo purposes this will be a base64 string
    let date:  String? // this will be im YYYY-MM-dd'T'HH:mm:ss format
}

//
//  UIImageExtension.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

extension UIImage {

    func base64Decode(strBase64: String?) -> UIImage?{
        
        guard let strBase64 = strBase64 else{return nil}
        
        let dataDecoded = Data(base64Encoded: strBase64, options: NSData.Base64DecodingOptions(rawValue: 0))
        guard let dataDecode = dataDecoded else{return nil}
        
        let decodedimage = UIImage(data: dataDecode)
        return decodedimage
    }
}


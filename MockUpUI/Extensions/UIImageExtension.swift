//
//  UIImageExtension.swift
//  MockUpUI
//
//  Created by Phil Martin on 03/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func base64Decode(strBase64: String?) -> UIImage?{
        
        guard let strBase64 = strBase64 else{return nil}
        
        let dataDecoded = Data(base64Encoded: strBase64, options: NSData.Base64DecodingOptions(rawValue: 0))
        guard let dataDecode = dataDecoded else{return nil}
        
        let decodedimage = UIImage(data: dataDecode)
        return decodedimage
    }
}


//
//  Alert.swift
//  MockUpUI
//
//  Created by Phil Martin on 16/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class Alert {
    
    func showAlertForBadData(title: String, body: String) -> UIAlertController{
        let controller = UIAlertController(title: title, message: body, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        return controller
    }
    
}

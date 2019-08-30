//
//  Helper.swift
//  MockUpUI
//
//  Created by Phil Martin on 30/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit

class Helper {
    func findRootViewcontroller() -> UIViewController?{
        guard let window = UIApplication.shared.delegate?.window else {
            return nil
        }
        return window?.rootViewController
    }
}


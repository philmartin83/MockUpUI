//
//  CellDataProtocol.swift
//  MockUpUI
//
//  Created by Phil Martin on 30/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation

protocol CellDataProtocol {
    associatedtype T
    // make this optional just in case!!!
    func setCellData(data: T?)
}

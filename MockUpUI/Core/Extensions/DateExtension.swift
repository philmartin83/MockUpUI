//
//  DateExtension.swift
//  MockUpUI
//
//  Created by Phil Martin on 30/08/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation

extension Date{
    /// Helper to convert the time passed in the mocked json response
    func convertServerDateTime(dateString: String?) -> String{
        let serverFormatter = DateFormatter()
        serverFormatter.dateFormat = serverFormat
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        guard let dateString = dateString else {return ""}
        let date = serverFormatter.date(from: dateString)
        guard let unwrappedDate = date else {return ""}
        let result = formatter.string(from: unwrappedDate)
        return result
    }
}

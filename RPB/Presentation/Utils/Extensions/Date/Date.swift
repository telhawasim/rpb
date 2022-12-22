//
//  Date.swift
//  RPB
//
//  Created by Telha Wasim on 22/12/2022.
//

import Foundation
import UIKit

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

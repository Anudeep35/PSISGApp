//
//  Date+Extension.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.string(from: self)
    }
    
}

//
//  Region.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

enum Direction: String {
    case east = "east"
    case west = "west"
    case north = "north"
    case south = "south"
    case central = "central"
    case national = "national"
}

struct Region {
    var direction: Direction
    var coord: CLLocationCoordinate2D
    
    init?(json: JSON) {
        guard let dir = Direction.init(rawValue: json["name"].stringValue) else {
            return nil
        }
        guard let lat = json["label_location"]["latitude"].double,
            let long = json["label_location"]["longitude"].double else {
                return nil
        }
        self.direction = dir
        self.coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
}

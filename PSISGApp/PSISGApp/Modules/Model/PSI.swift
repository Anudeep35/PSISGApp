//
//  PSI.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PSI {
    var regionMetadata: [JSON]!
    var items: [JSON]!
    
    init(json: JSON) {
        self.regionMetadata = json["region_metadata"].arrayValue
        self.items = json["items"].arrayValue
    }
}

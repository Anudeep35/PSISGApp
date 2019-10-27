//
//  PSIAnnotation.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation
import MapKit

class PSIAnnotation: NSObject, MKAnnotation {
    
    var psi: PSIData
    
    init(psi: PSIData) {
        self.psi = psi
    }
    
    public var coordinate: CLLocationCoordinate2D {
        return psi.region.coord
    }
    
    var title: String? {
        return psi.region.direction.rawValue
    }
    
    var subtitle: String? {
        return psi.descriptionText()
    }
}

//
//  PSIAnnotationView.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation
import MapKit

class PSIAnnotationView: MKMarkerAnnotationView {
    
    //Adding multiline subtitle
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        let width = NSLayoutConstraint(item: label,
                                       attribute: .width,
                                       relatedBy: .lessThanOrEqual,
                                       toItem: nil,
                                       attribute: .notAnAttribute,
                                       multiplier: 1,
                                       constant: 150)
        
        let height = NSLayoutConstraint(item: label,
                                        attribute: .height,
                                        relatedBy: .greaterThanOrEqual,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: 0)
        label.addConstraint(width)
        label.addConstraint(height)
        
        return label
    }()
    
}

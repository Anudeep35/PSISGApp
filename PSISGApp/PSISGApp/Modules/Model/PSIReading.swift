//
//  PSIReading.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PSIReading {
    var o3SubIndex: Int?
    var pm10TwentyFourHourly: Int?
    var pm10SubIndex: Int?
    var coSubIndex: Int?
    var pm25TwentyFourHourly: Int?
    var so2_sub_index: Int?
    var coEightHourMax: Int?
    var no2OneHourMax: Int?
    var so2TwentyFourHourly: Int?
    var pm25SubIndex: Int?
    var psiTwentyFourHourly: Int?
    var o3EightHourMax: Int?
    
    init(json: JSON, forDirection direction: String) {
        self.o3SubIndex = json["o3_sub_index"][direction].int
        self.pm10TwentyFourHourly = json["pm10_twenty_four_hourly"][direction].int
        self.pm10SubIndex = json["pm10_sub_index"][direction].int
        self.coSubIndex = json["co_sub_index"][direction].int
        self.pm25TwentyFourHourly = json["pm25_twenty_four_hourly"][direction].int
        self.so2_sub_index = json["so2_sub_index"][direction].int
        self.coEightHourMax = json["co_eight_hour_max"][direction].int
        self.no2OneHourMax = json["no2_one_hour_max"][direction].int
        self.so2TwentyFourHourly = json["so2_twenty_four_hourly"][direction].int
        self.pm25SubIndex = json["pm25_sub_index"][direction].int
        self.psiTwentyFourHourly = json["psi_twenty_four_hourly"][direction].int
        self.o3EightHourMax = json["o3_eight_hour_max"][direction].int
    }
}

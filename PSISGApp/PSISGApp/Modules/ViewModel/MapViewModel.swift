//
//  MapViewModel.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import Foundation
import SwiftyJSON

class MapViewModel {
    
    let apiService: APIServiceProtocol
    
    var psiDatas = [PSIData]()
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlert?()
        }
    }
    
    var numberOfAnnotations: Int {
        return psiDatas.count
    }
    
    var updateLoadingStatus: (()->())?
    var showAlert: (()->())?
    var loadMapPins: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetchPSI() {
        guard !isLoading else { return }
        isLoading = true
        
        self.apiService.request(router: Router.getPSI(date: Date())) { (result: Result<JSON, APIError>) in
            self.isLoading = false
            switch result {
            case .success(let psiJSON):
                let psi = PSI.init(json: psiJSON)
                self.createPSIData(psi: psi)
            case .failure(let error):
                self.alertMessage = error.localizedDescription
            }
        }
    }
    
    func createPSIData( psi: PSI) {
        for regionJSON in psi.regionMetadata {
            if let region = Region.init(json: regionJSON) {
                if region.direction != .national{
                    psiDatas.append(PSIData(region: region))
                }
            }
        }
        let readingJSON = psi.items[0]["readings"]
        for i in 0..<psiDatas.count {
            psiDatas[i].parseReadingFrom(json: readingJSON)
        }
        self.loadMapPins?()
    }
    
    func getPSIData(at index: Int ) -> PSIData {
        return psiDatas[index]
    }
}

struct PSIData {
    
    var region: Region
    var reading: PSIReading!
    
    init(region: Region) {
        self.region = region
    }
    
    mutating func parseReadingFrom(json: JSON) {
        self.reading = PSIReading(json: json, forDirection: self.region.direction.rawValue)
    }
    
    func descriptionText() -> String {
        var formatText = "o3_sub_index: " + self.getValue(value: self.reading.o3SubIndex)
        formatText.append("\n" + "pm10_twenty_four_hourly: " + self.getValue(value: self.reading.pm10TwentyFourHourly))
        formatText.append("\n" + "pm10_sub_index: " + self.getValue(value: self.reading.pm10SubIndex))
        formatText.append("\n" + "co_sub_index: " + self.getValue(value: self.reading.coSubIndex))
        formatText.append("\n" + "pm25_twenty_four_hourly: " + self.getValue(value: self.reading.pm25TwentyFourHourly))
        formatText.append("\n" + "so2_sub_index: " + self.getValue(value: self.reading.so2_sub_index))
        formatText.append("\n" + "co_eight_hour_max: " + self.getValue(value: self.reading.coEightHourMax))
        formatText.append("\n" + "no2_one_hour_max: " + self.getValue(value: self.reading.no2OneHourMax))
        formatText.append("\n" + "so2_twenty_four_hourly: " + self.getValue(value: self.reading.so2TwentyFourHourly))
        formatText.append("\n" + "pm25_sub_index: " + self.getValue(value: self.reading.pm25SubIndex))
        formatText.append("\n" + "psi_twenty_four_hourly: " + self.getValue(value: self.reading.psiTwentyFourHourly))
        formatText.append("\n" + "o3_eight_hour_max: " + self.getValue(value: self.reading.o3EightHourMax))
        return formatText
    }
    
    private func getValue<T>(value: T?) -> String {
        if let value = value {
            return "\(value)"
        } else {
            return "N/A"
        }
    }
}

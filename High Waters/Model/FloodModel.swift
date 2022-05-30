//
//  FloodModel.swift
//  High Waters
//
//  Created by Marco Mascorro on 5/29/22.
//

import Foundation


struct Flood {
    var latitude : Double
    var longitude: Double
}

struct FloodModel {
    var latitude : Double
    var longitude: Double
    
    
    init(dictionary: [String: Any]){
        self.latitude = dictionary["latitude"] as? Double ?? 0
        self.longitude = dictionary["longitude"] as? Double ?? 0
    }
}


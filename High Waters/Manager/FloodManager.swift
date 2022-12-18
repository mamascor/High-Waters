//
//  FloodManager.swift
//  High Waters
//
//  Created by Marco Mascorro on 5/29/22.
//

import UIKit
import Firebase



struct FloodService {
    
    static let shared = FloodService()
    
    func uploadFloor(location: Flood, completion: @escaping(Bool)-> Void){
        let longitude = location.longitude
        let latitude = location.latitude
        
        let values: [String:Any] = ["longitude": longitude, "latitude": latitude]
        //uploading coordinates
        let ref = REF_FLOODS.childByAutoId()
        
        ref.updateChildValues(values) { error, ref in
            if let error = error {
                print("DEBUG: There has been an error", error.localizedDescription)
                completion(false)
                return
            }
            print("DEBUG: Success uploading coordinate data.")
            completion(true)
            
        }
        
    }
    
    func fetchFloodData(completion: @escaping([FloodModel])-> Void){
        
        var floods = [FloodModel]()
        
        
        REF_FLOODS.observe(.childAdded) { snapshot in
            
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            
            let flood = FloodModel(dictionary: dictionary)
            
            floods.append(flood)
            
            completion(floods)
            
            
        }
        
        
    }
    
    
    
        
}

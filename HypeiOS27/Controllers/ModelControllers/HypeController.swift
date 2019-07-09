//
//  HypeController.swift
//  HypeiOS27
//
//  Created by Timothy Rosenvall on 7/9/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import CloudKit

class HypeController {
    
    // The Database we'll use.
    let publicDB = CKContainer.default().publicCloudDatabase
    // Source of truth
    var hypes: [Hype] = []
    
    // CRUD
    // Save
    func saveHype(with text: String, completion: @escaping (Bool) -> Void) {
        let hype = Hype(hypeText: text)
        guard let hypeRecord = CKRecord(hype: hype) else {return}
        publicDB.save(hypeRecord) { (_, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
            }
            self.hypes.append(hype)
            completion(true)
        }
    }
    
    // Fetch
    func fetchHypes(comption: @escaping (Bool) -> Void) {
        
    }
    
    // Subscription
    func subscribeToRemoteNotifications(completion: @escaping (Error?) -> Void) {
        
    }
}

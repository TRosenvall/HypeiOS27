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
    // Singleton
    static let sharedInstance = HypeController()
    
    // CRUD
    // Save
    func saveHype(with text: String, completion: @escaping (Bool) -> Void) {
        let hype = Hype(hypeText: text)
        guard let hypeRecord = CKRecord(hype: hype) else {return}
        publicDB.save(hypeRecord) { (_, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
            }
            self.hypes.insert(hype, at: 0)
            completion(true)
        }
    }
    
    // Fetch
    func fetchHypes(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: HypeConstants.recordTypeKey, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: HypeConstants.recordtimestampKey, ascending: false)]
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) :  \(error.localizedDescription) /n---/n \(error)")
                completion(false)
                return
            } else if let records = records {
                let hypes = records.compactMap({Hype(ckRecord: $0)})
                self.hypes = hypes
                completion(true)
            }
        }
    }
    
    // Subscription
    func subscribeToRemoteNotifications(completion: @escaping (Error?) -> Void) {
        
    }
}

//
//  Hype.swift
//  HypeiOS27
//
//  Created by Timothy Rosenvall on 7/9/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import CloudKit

struct HypeConstants {
    static let recordTypeKey = "Hype"
    fileprivate static let recordTextKey = "Text"
    fileprivate static let recordtimestampKey = ""
}

class Hype {
    let hypeText: String
    let timestamp: Date
    // Create a hype
    init(hypeText: String, timestamp: Date) {
        self.hypeText = hypeText
        self.timestamp = timestamp
    }
}

// Create a hype from a CKRecord
extension Hype {
    convenience init?(ckRecord: CKRecord) {
        guard let hypeText = ckRecord[HypeConstants.recordTextKey] as? String,
            let hypeTimestamp = ckRecord[HypeConstants.recordtimestampKey] as? Date
            else {return nil}
        self.init(hypeText: hypeText, timestamp: hypeTimestamp)
    }
}

// Create a CKRecord from a hype
extension CKRecord {
    convenience init?(hype: Hype) {
        self.init(recordType: HypeConstants.recordTypeKey)
        self.setValue(hype.hypeText, forKey: HypeConstants.recordTextKey)
        self.setValue(hype.timestamp, forKey: HypeConstants.recordtimestampKey)
    }
}

// This is not needed yet. It may be used for the report function later on.
//extension Hype: Equatable {
//    static func == (lhs: Hype, rhs: Hype) -> Bool {
//        return lhs.hypeText == rhs.hypeText && lhs.timestamp == rhs.timestamp
//    }
//}


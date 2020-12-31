//
//  CloudSingleValueContainer.swift
//
//
//  Created by Noah Desch on 12/30/20.
//

import Foundation
import CloudKit

struct CloudSingleValueEncodingContainer: SingleValueEncodingContainer {
    
    var codingPath: [CodingKey]
    
    private let keyBase: String
    
    private let record: CKRecord
    
    func encodeNil() throws {
        record["\(keyBase)"] = CloudRecordEncoder.nilMarker
    }
    
    func encode(_ value: Bool) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: String) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: Double) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: Float) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: Int) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: Int8) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: Int16) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: Int32) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: Int64) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: UInt) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: UInt8) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: UInt16) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: UInt32) throws {
        record["\(keyBase)"] = value
    }
    
    func encode(_ value: UInt64) throws {
        record["\(keyBase)"] = value
    }
    
    func encode<T>(_ value: T) throws where T : Encodable {
        let encoder = CloudRecordEncoder(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)"
        )
        try value.encode(to: encoder)
    }
    
    init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase.isEmpty ? "S" : keyBase
    }
}

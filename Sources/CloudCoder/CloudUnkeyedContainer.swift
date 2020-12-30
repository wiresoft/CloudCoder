//
//  CloudUnkeyedContainer.swift
//  
//
//  Created by Noah Desch on 12/30/20.
//

import Foundation
import CloudKit

struct CloudUnkeyedContainer: UnkeyedEncodingContainer, SingleValueEncodingContainer {
    
    var codingPath: [CodingKey]
    
    var count: Int
    
    private let keyBase: String
    
    private let record: CKRecord
    
    mutating func encodeNil() throws {
        record["\(keyBase)\(count)"] = CloudRecordEncoder.nilMarker
        count += 1
    }
    
    mutating func encode(_ value: Bool) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: String) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: Double) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: Float) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: Int) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: Int8) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: Int16) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: Int32) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: Int64) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: UInt) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: UInt8) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: UInt16) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: UInt32) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode(_ value: UInt64) throws {
        record["\(keyBase)\(count)"] = value
        count += 1
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        let encoder = CloudRecordEncoder(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)\(count)__")
        try value.encode(to: encoder)
        count += 1
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        return KeyedEncodingContainer(CloudKeyedContainer<NestedKey>(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)\(count)__"
        ))
        count += 1
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        return CloudUnkeyedContainer(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)\(count)__"
        )
        count += 1
    }
    
    mutating func superEncoder() -> Encoder {
        return CloudRecordEncoder(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)super__"
        )
    }
    
    init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase
        self.count = 0
    }
    
    private enum LocalKey: String, CodingKey {
        case superKey
    }
}

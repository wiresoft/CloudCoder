//
//  CloudKeyedContainer.swift
//
//
//  Created by Noah Desch on 12/29/20.
//

import Foundation
import CloudKit

struct CloudKeyedEncodingContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {
    
    public var codingPath: [CodingKey]
    
    private let keyBase: String
    
    private let record: CKRecord
    
    public mutating func encodeNil(forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = CloudRecordEncoder.nilMarker
    }
    
    public mutating func encode(_ value: Bool, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: String, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: Double, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: Float, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: Int, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: Int8, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: Int16, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: Int32, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: Int64, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: UInt, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: UInt8, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: UInt16, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: UInt32, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode(_ value: UInt64, forKey key: Key) throws {
        record["\(keyBase)\(key.stringValue)"] = value
    }
    
    public mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        let encoder = CloudRecordEncoder(
            path: self.codingPath + [key],
            record: self.record,
            keyBase: "\(keyBase)\(key.stringValue)"
        )
        try value.encode(to: encoder)
    }
    
    public mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        return KeyedEncodingContainer(CloudKeyedEncodingContainer<NestedKey>(
            path: self.codingPath + [key],
            record: self.record,
            keyBase: "\(keyBase)\(key.stringValue)"
        ))
    }
    
    public mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        return CloudUnkeyedEncodingContainer(
            path: self.codingPath + [key],
            record: self.record,
            keyBase: "\(keyBase)\(key.stringValue)"
        )
    }
    
    public mutating func superEncoder() -> Encoder {
        return CloudRecordEncoder(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)super"
        )
    }
    
    public mutating func superEncoder(forKey key: Key) -> Encoder {
        return CloudRecordEncoder(
            path: self.codingPath + [key],
            record: self.record,
            keyBase: "\(keyBase)\(key.stringValue)"
        )
    }
    
    init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase.isEmpty ? keyBase : keyBase + "_"
    }
}

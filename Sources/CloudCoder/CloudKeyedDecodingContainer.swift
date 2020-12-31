//
//  CloudKeyedDecodingContainer.swift
//  
//
//  Created by Noah Desch on 12/30/20.
//

import Foundation
import CloudKit

struct CloudKeyedDecodingContainer<Key>: KeyedDecodingContainerProtocol where Key: CodingKey {
    let codingPath: [CodingKey]
    
    let allKeys: [Key]
    
    private let keyBase: String
    
    private let record: CKRecord
    
    func contains(_ key: Key) -> Bool {
        return allKeys.contains(where: { $0.stringValue == key.stringValue })
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        if let value = record["\(keyBase)\(key.stringValue)"] as? String {
            return value == CloudRecordEncoder.nilMarker
        } else {
            return false
        }
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        if let value = record["\(keyBase)\(key.stringValue)"] as? Bool {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        if let value = record["\(keyBase)\(key.stringValue)"] as? String {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        if let value = record["\(keyBase)\(key.stringValue)"] as? Double {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        if let value = record["\(keyBase)\(key.stringValue)"] as? Float {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        if let value = record["\(keyBase)\(key.stringValue)"] as? Int {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        if let value = record["\(keyBase)\(key.stringValue)"] as? Int8 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        if let value = record["\(keyBase)\(key.stringValue)"] as? Int16 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        if let value = record["\(keyBase)\(key.stringValue)"] as? Int32 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        if let value = record["\(keyBase)\(key.stringValue)"] as? Int64 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        if let value = record["\(keyBase)\(key.stringValue)"] as? UInt {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        if let value = record["\(keyBase)\(key.stringValue)"] as? UInt8 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        if let value = record["\(keyBase)\(key.stringValue)"] as? UInt16 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        if let value = record["\(keyBase)\(key.stringValue)"] as? UInt32 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        if let value = record["\(keyBase)\(key.stringValue)"] as? UInt64 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "")
        }
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        let decoder = CloudRecordDecoder(
            path: self.codingPath + [key],
            record: self.record,
            keyBase: "\(keyBase)\(key.stringValue)"
        )
        return try type.init(from: decoder)
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        return KeyedDecodingContainer(CloudKeyedDecodingContainer<NestedKey>(
            path: self.codingPath + [key],
            record: self.record,
            keyBase: "\(keyBase)\(key.stringValue)"
        ))
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        return CloudUnkeyedDecodingContainer(
            path: self.codingPath + [key],
            record: self.record,
            keyBase: "\(keyBase)\(key.stringValue)"
        )
    }
    
    func superDecoder() throws -> Decoder {
        return CloudRecordDecoder(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)super"
        )
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        return CloudRecordDecoder(
            path: self.codingPath + [key],
            record: self.record,
            keyBase: "\(keyBase)\(key.stringValue)"
        )
    }
    
    init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase.isEmpty ? keyBase : keyBase + "_"
        self.allKeys = record.subKeysFromBase(keyBase).compactMap { Key(stringValue: $0) }
    }
}

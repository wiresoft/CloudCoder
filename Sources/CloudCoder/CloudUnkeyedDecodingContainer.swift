//
//  CloudUnkeyedDecodingContainer.swift
//  
//
//  Created by Noah Desch on 12/30/20.
//

import Foundation
import CloudKit

struct CloudUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    
    var codingPath: [CodingKey]
    
    var count: Int?
    
    var isAtEnd: Bool
    
    var currentIndex: Int
    
    private let keyBase: String
    
    private let record: CKRecord
    
    mutating func decodeNil() throws -> Bool {
        if let value = record["\(keyBase)\(currentIndex)"] as? String {
            return value == CloudRecordEncoder.nilMarker
        } else {
            return false
        }
    }
    
    mutating func decode(_ type: Bool.Type) throws -> Bool {
        if let value = record["\(keyBase)\(currentIndex)"] as? Bool {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: String.Type) throws -> String {
        if let value = record["\(keyBase)\(currentIndex)"] as? String {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: Double.Type) throws -> Double {
        if let value = record["\(keyBase)\(currentIndex)"] as? Double {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: Float.Type) throws -> Float {
        if let value = record["\(keyBase)\(currentIndex)"] as? Float {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        if let value = record["\(keyBase)\(currentIndex)"] as? Int {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        if let value = record["\(keyBase)\(currentIndex)"] as? Int8 {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        if let value = record["\(keyBase)\(currentIndex)"] as? Int16 {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        if let value = record["\(keyBase)\(currentIndex)"] as? Int32 {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        if let value = record["\(keyBase)\(currentIndex)"] as? Int64 {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        if let value = record["\(keyBase)\(currentIndex)"] as? UInt {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        if let value = record["\(keyBase)\(currentIndex)"] as? UInt8 {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        if let value = record["\(keyBase)\(currentIndex)"] as? UInt16 {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        if let value = record["\(keyBase)\(currentIndex)"] as? UInt32 {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        if let value = record["\(keyBase)\(currentIndex)"] as? UInt64 {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        defer {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
        }
        let decoder = CloudRecordDecoder(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)\(currentIndex)"
        )
        return try T(from: decoder)
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        defer {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
        }
        return KeyedDecodingContainer(CloudKeyedDecodingContainer<NestedKey>(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)\(currentIndex)"
        ))
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        defer {
            currentIndex += 1
            isAtEnd = currentIndex >= (count ?? 0)
        }
        return CloudUnkeyedDecodingContainer(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)\(currentIndex)"
        )
    }
    
    mutating func superDecoder() throws -> Decoder {
        return CloudRecordDecoder(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)super"
        )
    }
    
    init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase.isEmpty ? keyBase : keyBase + "_"
        self.currentIndex = 0
        
        let recordCount = record.subKeysFromBase(keyBase).count
        self.count = recordCount
        self.isAtEnd = recordCount == 0
    }
}

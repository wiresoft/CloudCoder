//
//  CloudSingleValueDecodingContainer.swift
//
//
//  Created by Noah Desch on 12/30/20.
//

import Foundation
import CloudKit

struct CloudSingleValueDecodingContainer: SingleValueDecodingContainer {
    
    var codingPath: [CodingKey]
    
    private let keyBase: String
    
    private let record: CKRecord
    
    func decodeNil() -> Bool {
        if let value = record[keyBase] as? String {
            return value == CloudRecordEncoder.nilMarker
        } else {
            return false
        }
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        if let value = record[keyBase] as? Bool {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: String.Type) throws -> String {
        if let value = record[keyBase] as? String {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        if let value = record[keyBase] as? Double {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        if let value = record[keyBase] as? Float {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        if let value = record[keyBase] as? Int {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        if let value = record[keyBase] as? Int8 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        if let value = record[keyBase] as? Int16 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        if let value = record[keyBase] as? Int32 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        if let value = record[keyBase] as? Int64 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        if let value = record[keyBase] as? UInt {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        if let value = record[keyBase] as? UInt8 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        if let value = record[keyBase] as? UInt16 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        if let value = record[keyBase] as? UInt32 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        if let value = record[keyBase] as? UInt64 {
            return value
        } else {
            throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
        }
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        let decoder = CloudRecordDecoder(
            path: self.codingPath,
            record: self.record,
            keyBase: keyBase
        )
        return try T(from: decoder)
    }
    
    init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase.isEmpty ? "S" : keyBase
    }
}

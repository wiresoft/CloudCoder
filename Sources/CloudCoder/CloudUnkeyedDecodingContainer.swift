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
    
    var count: Int? {
        return nil
    }
    
    var isAtEnd: Bool {
        return storage?.isAtEnd ?? (record[keyBase] == nil)
    }
    
    var currentIndex: Int {
        return storage?.currentIndex ?? 0
    }
    
    private let keyBase: String
    
    private let record: CKRecord
    
    private var storage: HomogeneousDecodingContainer?
    
    private mutating func decodeNext<T>(_ type: T.Type) throws -> T where T: CKRecordValueProtocol {
        if let storage = storage {
            return try decodeNext(T.self, from: storage)
        } else {
            let storage = try HomogeneousArrayDecoder(type: T.self, record: record, key: keyBase, path: codingPath)
            self.storage = storage
            return try decodeNext(T.self, from: storage)
        }
    }
    
    private func decodeNext<T>(_ type: T.Type, from storage: HomogeneousDecodingContainer) throws -> T {
        if let result = storage.decodeNext() as? T {
            return result
        } else {
            throw DecodingError.typeMismatch(T.self, DecodingError.Context(codingPath: codingPath, debugDescription: "Unkeyed container element could not be converted to \(T.self)"))
        }
    }
    
    mutating func decodeNil() throws -> Bool {
        fatalError("Unkeyed container can't encode Nil")
    }
    
    mutating func decode(_ type: Bool.Type) throws -> Bool {
        return try decodeNext(Bool.self)
    }
    
    mutating func decode(_ type: String.Type) throws -> String {
        return try decodeNext(String.self)
    }
    
    mutating func decode(_ type: Double.Type) throws -> Double {
        return try decodeNext(Double.self)
    }
    
    mutating func decode(_ type: Float.Type) throws -> Float {
        return try decodeNext(Float.self)
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        return try decodeNext(Int.self)
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        return try decodeNext(Int8.self)
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        return try decodeNext(Int16.self)
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        return try decodeNext(Int32.self)
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        return try decodeNext(Int64.self)
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        return try decodeNext(UInt.self)
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try decodeNext(UInt8.self)
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try decodeNext(UInt16.self)
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try decodeNext(UInt32.self)
    }
    
    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try decodeNext(UInt64.self)
    }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        switch type {
        case is Bool.Type:
            return try decodeNext(Bool.self) as! T
        case is String.Type:
            return try decodeNext(String.self) as! T
        case is Double.Type:
            return try decodeNext(Double.self) as! T
        case is Float.Type:
            return try decodeNext(Float.self) as! T
        case is Int.Type:
            return try decodeNext(Int.self) as! T
        case is Int8.Type:
            return try decodeNext(Int8.self) as! T
        case is Int16.Type:
            return try decodeNext(Int16.self) as! T
        case is Int32.Type:
            return try decodeNext(Int32.self) as! T
        case is Int64.Type:
            return try decodeNext(Int64.self) as! T
        case is UInt.Type:
            return try decodeNext(UInt.self) as! T
        case is UInt8.Type:
            return try decodeNext(UInt8.self) as! T
        case is UInt16.Type:
            return try decodeNext(UInt16.self) as! T
        case is UInt32.Type:
            return try decodeNext(UInt32.self) as! T
        case is UInt64.Type:
            return try decodeNext(UInt64.self) as! T
        case is Data.Type:
            return try decodeNext(Data.self) as! T
        case is Date.Type:
            return try decodeNext(Date.self) as! T
        case is CKAsset.Type:
            return try decodeNext(CKAsset.self) as! T
        case is CKRecord.Reference.Type:
            return try decodeNext(CKRecord.Reference.self) as! T
        default:
            fatalError("Unkeyed containers can only encode primitive values. Consider encoding \(T.self) as a top-level record and using CloudKit parent references to associate it with it's parent type")
        }
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        fatalError("Unkeyed containers can only encode primitive values. Consider encoding your nested container as a top-level record and using CloudKit parent references to associate it with it's parent type")
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        fatalError("Unkeyed containers can only encode primitive values. Consider encoding your nested container as a top-level record and using CloudKit parent references to associate it with it's parent type")
    }
    
    mutating func superDecoder() throws -> Decoder {
        return CloudRecordDecoder(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)_super"
        )
    }
    
    init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase.isEmpty ? "U" : keyBase
    }
}

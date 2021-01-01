//
//  CloudUnkeyedContainer.swift
//  
//
//  Created by Noah Desch on 12/30/20.
//

import Foundation
import CloudKit

struct CloudUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    
    var codingPath: [CodingKey]
    
    var count: Int {
        return storage?.count ?? 0
    }
    
    private let keyBase: String
    
    private let record: CKRecord
    
    private var storage: HomogeneousEncodingContainer?
    
    private mutating func append<T: CKRecordValueProtocol>(_ value: T) throws {
        if let arrayStorage = storage {
            try arrayStorage.append(value)
        } else {
            let arrayStorage = HomogeneousArrayEncoder(
                type: T.self,
                record: self.record,
                key: keyBase,
                path: codingPath
            )
            try arrayStorage.append(value)
            storage = arrayStorage
        }
    }
    
    mutating func encodeNil() throws {
        fatalError("Unkeyed container can't encode Nil")
    }
    
    mutating func encode(_ value: Bool) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: String) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: Double) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: Float) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: Int) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: Int8) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: Int16) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: Int32) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: Int64) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: UInt) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: UInt8) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: UInt16) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: UInt32) throws {
        try self.append(value)
    }
    
    mutating func encode(_ value: UInt64) throws {
        try self.append(value)
    }
    
    mutating func encode<T>(_ value: T) throws where T : Encodable {
        switch value {
        case let typedValue as Bool:
            try self.append(typedValue)
        case let typedValue as String:
            try self.append(typedValue)
        case let typedValue as Double:
            try self.append(typedValue)
        case let typedValue as Float:
            try self.append(typedValue)
        case let typedValue as Int:
            try self.append(typedValue)
        case let typedValue as Int8:
            try self.append(typedValue)
        case let typedValue as Int16:
            try self.append(typedValue)
        case let typedValue as Int32:
            try self.append(typedValue)
        case let typedValue as Int64:
            try self.append(typedValue)
        case let typedValue as UInt:
            try self.append(typedValue)
        case let typedValue as UInt8:
            try self.append(typedValue)
        case let typedValue as UInt16:
            try self.append(typedValue)
        case let typedValue as UInt32:
            try self.append(typedValue)
        case let typedValue as UInt64:
            try self.append(typedValue)
        case let typedValue as CLLocation:
            try self.append(typedValue)
        case let typedValue as Data:
            try self.append(typedValue)
        case let typedValue as Date:
            try self.append(typedValue)
        case let typedValue as CKAsset:
            try self.append(typedValue)
        case let typedValue as CKRecord.Reference:
            try self.append(typedValue)
        default:
            fatalError("Unkeyed containers can only encode primitive values. Consider encoding \(T.self) as a top-level record and using CloudKit parent references to associate it with it's parent type")
        }
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        fatalError("Unkeyed containers can only encode primitive values. Consider encoding your nested container as a top-level record and using CloudKit parent references to associate it with it's parent type")
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("Unkeyed containers can only encode primitive values. Consider encoding your nested container as a top-level record and using CloudKit parent references to associate it with it's parent type")
    }
    
    mutating func superEncoder() -> Encoder {
        return CloudRecordEncoder(
            path: self.codingPath,
            record: self.record,
            keyBase: "\(keyBase)_super"
        )
    }
    
    init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase.isEmpty ? "U" : keyBase
        self.storage = nil
    }
}

//
//  CloudCoder.swift
//
//
//  Created by Noah Desch on 12/29/20.
//

import CloudKit
import Combine

/// Encodes to CloudKit `CKRecord`
public final class CloudRecordEncoder: Encoder {
    
    public var codingPath: [CodingKey]
    
    public var userInfo: [CodingUserInfoKey : Any] {
        return [:]
    }
    
    public let zoneID: CKRecordZone.ID
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        return KeyedEncodingContainer(CloudKeyedEncodingContainer<Key>(path: codingPath, record: record!, keyBase: self.keyBase))
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        return CloudUnkeyedEncodingContainer(path: codingPath, record: record!, keyBase: self.keyBase)
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        return CloudSingleValueEncodingContainer(
            path: self.codingPath,
            record: self.record!,
            keyBase: self.keyBase
        )
    }
    
    public func encode<Value>(_ value: Value, as type: CKRecord.RecordType? = nil) throws -> CKRecord where Value : Encodable, Value : Identifiable, Value.ID : CustomStringConvertible {
        let id = CKRecord.ID(recordName: String(describing: value.id), zoneID: zoneID)
        let record = CKRecord(recordType: type ?? String(describing: Value.self), recordID: id)
        self.record = record
        try value.encode(to: self)
        
        return record
    }
    
    public init(zoneID: CKRecordZone.ID = CKRecordZone.ID.default) {
        self.codingPath = []
        self.record = nil
        self.zoneID = zoneID
        self.keyBase = ""
    }
    
    //
    // MARK: - Internal
    //
    
    private var record: CKRecord?
    
    private let keyBase: String
    
    internal static let nilMarker = "<<<_NULL_>>>"
    
    internal init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase
        self.zoneID = record.recordID.zoneID
    }
    
}

/// Decodes from CloudKit `CKRecord`
public final class CloudRecordDecoder: Decoder, TopLevelDecoder {
    
    public typealias Input = CKRecord
    
    public var codingPath: [CodingKey]
    
    public var userInfo: [CodingUserInfoKey : Any] {
        return [:]
    }
    
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        KeyedDecodingContainer(CloudKeyedDecodingContainer(
            path: self.codingPath,
            record: self.record!,
            keyBase: self.keyBase
        ))
    }
    
    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return CloudUnkeyedDecodingContainer(
            path: self.codingPath,
            record: self.record!,
            keyBase: self.keyBase
        )
    }
    
    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return CloudSingleValueDecodingContainer(
            path: self.codingPath,
            record: self.record!,
            keyBase: self.keyBase
        )
    }
    
    public init() {
        self.codingPath = []
        self.record = nil
        self.keyBase = ""
    }
    
    public func decode<T>(_ type: T.Type, from record: Input) throws -> T where T : Decodable {
        self.record = record
        return try T(from: self)
    }
    
    //
    // MARK: - Internal
    //
    
    private var record: CKRecord?
    
    private let keyBase: String
    
    internal init(path: [CodingKey], record: CKRecord, keyBase: String) {
        self.codingPath = path
        self.record = record
        self.keyBase = keyBase
    }
}

extension CKRecord {
    func subKeysFromBase(_ keyBase: String) -> [CKRecord.FieldKey] {
        let someKeys = self.allKeys().compactMap { (key) -> String? in
            guard key.count > keyBase.count else { return nil }
            guard key.hasPrefix(keyBase) else { return nil }
            
            var partial = key.dropFirst(keyBase.count)
            if partial.popFirst() == "_" {
                if let end = partial.firstIndex(of: "_") {
                    return String(partial[..<end])
                } else {
                    return String(partial)
                }
            } else {
                return nil
            }
        }
        // remove duplicates
        return Array<String>(Set<String>(someKeys))
    }
}

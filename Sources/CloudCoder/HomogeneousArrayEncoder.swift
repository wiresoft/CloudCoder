//
//  HomogeneousArrayEncoder.swift
//  
//
//  Created by Noah Desch on 12/31/20.
//

import Foundation
import CloudKit

protocol HomogeneousEncodingContainer {
    var count: Int {get}
    func append<T: CKRecordValueProtocol>(_ value: T) throws
}

final class HomogeneousArrayEncoder<Value>: HomogeneousEncodingContainer where Value: CKRecordValueProtocol {
    
    private let codingPath: [CodingKey]
    
    private let record: CKRecord
    
    private let key: String
    
    private var array: [Value]
    
    var count: Int {
        return array.count
    }
    
    func append<T: CKRecordValueProtocol>(_ value: T) throws {
        if let value = value as? Value {
            array.append(value)
            record[key] = array
        } else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: self.codingPath, debugDescription: "Unkeyed container values must be homogeneous"))
        }
    }
    
    init(type: Value.Type, record: CKRecord, key: String, path: [CodingKey]) {
        self.array = []
        self.codingPath = path
        self.record = record
        self.key = key
    }
}

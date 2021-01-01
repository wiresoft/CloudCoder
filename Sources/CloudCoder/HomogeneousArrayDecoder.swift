//
//  HomogeneousArrayDecoder.swift
//
//
//  Created by Noah Desch on 12/31/20.
//

import Foundation
import CloudKit

protocol HomogeneousDecodingContainer {
    var count: Int {get}
    var currentIndex: Int {get}
    var isAtEnd: Bool {get}
    func decodeNext() -> Any
}

final class HomogeneousArrayDecoder<Value>: HomogeneousDecodingContainer where Value: CKRecordValueProtocol {
    
    private let codingPath: [CodingKey]
    
    private let record: CKRecord
    
    private let key: String
    
    private var array: [Value]
    
    private(set) var currentIndex: Int
    
    var count: Int {
        return array.count
    }
    
    var isAtEnd: Bool {
        return currentIndex >= array.count
    }
    
    func decodeNext() -> Any {
        defer { currentIndex += 1 }
        return array[currentIndex]
    }
    
    init(type: Value.Type, record: CKRecord, key: String, path: [CodingKey]) throws {
        let array: [Value]
        if let ckValue = record[key] {
            guard let typedArray = ckValue as? [Value] else {
                throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: path, debugDescription: "Could not decode array of \(Value.self)"))
            }
            array = typedArray
        } else {
            // no key can be an empty array
            array = []
        }
        
        self.array = array
        self.codingPath = path
        self.record = record
        self.key = key
        self.currentIndex = 0
    }
}

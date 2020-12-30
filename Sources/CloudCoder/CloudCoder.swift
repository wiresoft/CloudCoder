import CloudKit

public final class CloudRecordEncoder: Encoder {
    
    public typealias Output = CKRecord
    
    public var codingPath: [CodingKey]
    
    public var userInfo: [CodingUserInfoKey : Any] {
        return [:]
    }
    
    public let recordType: CKRecord.RecordType
    
    public let zoneID: CKRecordZone.ID
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        return KeyedEncodingContainer(CloudKeyedEncodingContainer<Key>(path: codingPath, record: record!, keyBase: self.keyBase))
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        return CloudUnkeyedEncodingContainer(path: codingPath, record: record!, keyBase: self.keyBase)
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        return CloudUnkeyedEncodingContainer(path: codingPath, record: record!, keyBase: self.keyBase)
    }
    
    public func encode<Value>(_ value: Value) throws -> CKRecord where Value : Encodable, Value : Identifiable, Value.ID : CustomStringConvertible {
        let id = CKRecord.ID(recordName: String(describing: value.id), zoneID: zoneID)
        let record = CKRecord(recordType: recordType, recordID: id)
        self.record = record
        try value.encode(to: self)
        return record
    }
    
    public init(type: CKRecord.RecordType, in zoneID: CKRecordZone.ID = CKRecordZone.ID.default) {
        self.codingPath = []
        self.recordType = type
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
        self.recordType = record.recordType
        self.keyBase = keyBase
        self.zoneID = record.recordID.zoneID
    }
    
}

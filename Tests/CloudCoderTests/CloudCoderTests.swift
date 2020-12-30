import XCTest
@testable import CloudCoder

final class CloudCoderTests: XCTestCase {
    
    struct TestValue: Codable, Identifiable {
        var id = UUID(uuidString: "A3907DA1-8A40-4383-A8A1-BCDFB7BAE0F5")!
        var number = 5
        var boolean = false
        var double = 5.5
        var name = "something"
        var subValue = SubValue()
    }
    
    struct SubValue: Codable {
        var number = 10
        var boolean = true
        var double = 11.5
        var name = "else"
    }
    
    
    func testEncoding() throws {
        
        let encoder = CloudRecordEncoder(type: "TestValue")
        let value = TestValue()
        let record = try encoder.encode(value)
        
        XCTAssert(record.recordID.recordName == value.id.uuidString)
        XCTAssert(record.recordID.zoneID == CKRecordZone.ID.default)
        XCTAssert(record["number"] == value.number)
        XCTAssert(record["boolean"] == value.boolean)
        XCTAssert(record["double"] == value.double)
        XCTAssert(record["name"] == value.name)
        XCTAssert(record["subValue__number"] == value.subValue.number)
        XCTAssert(record["subValue__boolean"] == value.subValue.boolean)
        XCTAssert(record["subValue__double"] == value.subValue.double)
        XCTAssert(record["subValue__name"] == value.subValue.name)
    }
}

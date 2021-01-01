import XCTest
@testable import CloudCoder

final class CloudCoderTests: XCTestCase {
    
    struct TestValue: Codable, Identifiable {
        var id = UUID(uuidString: "A3907DA1-8A40-4383-A8A1-BCDFB7BAE0F5")!
        var number = 5
        var boolean = false
        var double = 5.5
        var name = "something"
        var array = [1,2,3,4]
        var intDict = [1: "one", 2: "two"]
        var stringSet: Set<String> = ["alpha", "beta", "delta"]
        var subValue = SubValue()
    }
    
    struct SubValue: Codable {
        var number = 10
        var boolean = true
        var double = 11.5
        var name = "else"
        var array = ["one", "two", "three"]
        var dict = ["one": 1, "two": 2]
    }
    
    
    func testBasicEncoding() throws {
        
        let encoder = CloudRecordEncoder()
        let value = TestValue()
        let record = try encoder.encode(value)
        
        // make sure record type and ID are inferred correctly
        XCTAssert(record.recordType == "TestValue")
        XCTAssert(record.recordID.recordName == value.id.uuidString)
        XCTAssert(record.recordID.zoneID == CKRecordZone.ID.default)
        
        // make sure the keys are what we expect
        XCTAssert(record["id"] == value.id)
        XCTAssert(record["number"] == value.number)
        XCTAssert(record["boolean"] == value.boolean)
        XCTAssert(record["double"] == value.double)
        XCTAssert(record["name"] == value.name)
        XCTAssert(record["array"] == value.array)
        XCTAssert(record["intDict_1"] == value.intDict[1])
        XCTAssert(record["intDict_2"] == value.intDict[2])
        XCTAssert(record["stringSet"] != nil)
        XCTAssert(record["subValue_number"] == value.subValue.number)
        XCTAssert(record["subValue_boolean"] == value.subValue.boolean)
        XCTAssert(record["subValue_double"] == value.subValue.double)
        XCTAssert(record["subValue_name"] == value.subValue.name)
    }
    
    func testBasicRoundTrip() throws {
        
        let encoder = CloudRecordEncoder()
        let decoder = CloudRecordDecoder()
        let value = TestValue()
        let record = try encoder.encode(value)
        
        let output = try decoder.decode(TestValue.self, from: record)
        XCTAssert(output.id == value.id)
        XCTAssert(output.number == value.number)
        XCTAssert(output.boolean == value.boolean)
        XCTAssert(output.double == value.double)
        XCTAssert(output.name == value.name)
        XCTAssert(output.array == value.array)
        XCTAssert(output.intDict == value.intDict)
        XCTAssert(output.stringSet == value.stringSet)
        XCTAssert(output.subValue.number == value.subValue.number)
        XCTAssert(output.subValue.boolean == value.subValue.boolean)
        XCTAssert(output.subValue.double == value.subValue.double)
        XCTAssert(output.subValue.name == value.subValue.name)
        XCTAssert(output.subValue.array == value.subValue.array)
        XCTAssert(output.subValue.dict == value.subValue.dict)
    }
    
    func testEmptyCollections() throws {
        let encoder = CloudRecordEncoder()
        let decoder = CloudRecordDecoder()
        var value = TestValue()
        
        value.array = []
        value.intDict = [:]
        value.stringSet = []
        value.subValue.array = []
        value.subValue.dict = [:]
        
        let record = try encoder.encode(value)
        
        let output = try decoder.decode(TestValue.self, from: record)
        XCTAssert(output.id == value.id)
        XCTAssert(output.number == value.number)
        XCTAssert(output.boolean == value.boolean)
        XCTAssert(output.double == value.double)
        XCTAssert(output.name == value.name)
        XCTAssert(output.array == value.array)
        XCTAssert(output.intDict == value.intDict)
        XCTAssert(output.stringSet == value.stringSet)
        XCTAssert(output.subValue.number == value.subValue.number)
        XCTAssert(output.subValue.boolean == value.subValue.boolean)
        XCTAssert(output.subValue.double == value.subValue.double)
        XCTAssert(output.subValue.name == value.subValue.name)
        XCTAssert(output.subValue.array == value.subValue.array)
        XCTAssert(output.subValue.dict == value.subValue.dict)
    }
}

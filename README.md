# CloudCoder

Codable support for Encoding and Decoding to `CKRecord`s for storage in CloudKit, with some caveats:

- Unkeyed containers are stored as arrays within the `CKRecord`
- As such: unkeyed containers (used for `Array`, `Set`, etc...) can only store homogeneous *primitive* types.
- Be careful using `Dictionary` because the dictionary keys are used to build keys within the CKRecord, so any keys you use must be part of your schema.
- CloudCoder will store nested complex types in Keyed containers (used for struct, class, dictionary, etc...) as snake_case keys beneath the parent type. 
- The top-level item being encoded must conform to `Identifiable where ID: CustomStringConvertible`  from which the CKRecord.ID will be derived.

In this examplem, the CKRecord will have keys: "id", "name", "sub_name", "sub_someValue"
```
struct Element: Codable, Identifiable {
    var id = UUID
    var name = "My Name"
    var sub: SubElement()
}

struct SubElement: Codable {
    var name = "Other Name"
    var someValue = 42
}

let value = Element()

// Encode
let encoder = CloudRecordEncoder()
let record = try encoder.encode(value)

// Decode
let decoder = CloudRecordDecoder()
let decodedValue = try decoder.decode(Element.self, from: record)
```


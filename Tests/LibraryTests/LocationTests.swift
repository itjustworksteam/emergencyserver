import XCTest
@testable import Library

class LocationTests: XCTestCase {
    
    func testConstants() {
        XCTAssertEqualWithAccuracy(3.1415, Constants.PI, accuracy: 1, "should be equals")
        XCTAssertEqualWithAccuracy(6371.0, Constants.EarthRadius, accuracy: 1, "should be equals")
        XCTAssertEqualWithAccuracy(180.0, Constants.StraightAngle, accuracy: 1, "should be equals")
    }
    
    func testUtils() {
        XCTAssertEqualWithAccuracy(3.1415, Utils.gradToRad(grad: 180.0), accuracy: 1, "should be equals")
        XCTAssertEqualWithAccuracy(1.0, Utils.disgeod(latA: 1.0, lonA: 1.0, latB: 1.0, lonB: 1.0), accuracy: 1, "should be equals")
    }
    
    static var allTests: [(String, (LocationTests) -> () throws -> Void)] {
        return [
            ("testConstants", testConstants),
            ("testUtils", testUtils),
        ]
    }

    
}

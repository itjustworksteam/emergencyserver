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
    
    func testCityConstructor() {
        _ = City(latitude: 1.0, longitude: 1.0)
        _ = City(latitude: 1.0, longitude: 1.0, name: "Name", code: "IT")
    }
    
    func testLatitudeAndLongitude() {
        let city = City(latitude: 1.0, longitude: 1.0)
        XCTAssertEqual(1.0, city.latitude, "should be equals")
        XCTAssertEqual(1.0, city.longitude, "should be equals")
        XCTAssertNil(city.name, "should be nil")
        XCTAssertNil(city.code, "should be nil")
    }
    
    func testNameAndCode() {
        let city = City(latitude: 1.0, longitude: 1.0, name: "Name", code: "IT")
        XCTAssertEqual(1.0, city.latitude, "should be equals")
        XCTAssertEqual(1.0, city.longitude, "should be equals")
        XCTAssertEqual("Name", city.name, "should be equals")
        XCTAssertEqual("IT", city.code, "should be equals")
    }
    
    func testDistanceToCity() {
        let city = City(latitude: 1.0, longitude: 1.0)
        let city2 = City(latitude: 1.0, longitude: 1.0)
        XCTAssertEqualWithAccuracy(0.0, city.distanceToCity(city2), accuracy: 1, "should be equals")
        XCTAssertEqualWithAccuracy(0.0, city2.distanceToCity(city), accuracy: 1, "should be equals")
    }
    
    func testDistanceRomeAndMilan() {
        let milan = City(latitude: 45.463688, longitude: 9.188141)
        let rome = City(latitude: 41.895466, longitude: 12.482324)
        XCTAssertEqualWithAccuracy(476.0, milan.distanceToCity(rome), accuracy: 1, "should be equals")
        XCTAssertEqualWithAccuracy(476.0, rome.distanceToCity(milan), accuracy: 1, "should be equals")
    }
    
    func testMakeJsonWithOnlyLatitudeAndLongitude() {
        let milan = City(latitude: 45.463688, longitude: 9.188141)
        XCTAssertEqual(jsonWithOnlyLatitudeAndLongitudeResponse(), milan.makeJson(), "should be equals")
    }
    
    func testMakeJsonWithAll() {
        let milan = City(latitude: 45.463688, longitude: 9.188141, name: "Milan", code: "IT")
        XCTAssertEqual(jsonWithAll(), milan.makeJson(), "should be equals")
    }
    
    func testCustomStringConvertibleLong(){
        let milan = City(latitude: 45.463688, longitude: 9.188141, name: "Milan", code: "IT")
        XCTAssertEqual("City={latitude=\"45.463688\", longitude=\"9.188141\", name=Milan, code=IT}", "\(milan)")
    }
    
    func testCustomStringConvertibleShort() {
        let milan = City(latitude: 45.463688, longitude: 9.188141)
        XCTAssertEqual("City={latitude=\"45.463688\", longitude=\"9.188141\"}", "\(milan)")
    }
    
    private func jsonWithAll() -> String {
        var response = ""
        response += "{\"latitude\":\"45.463688\",\"longitude\":\"9.188141\",\"city\":\"Milan\",\"code\":\"IT\"}"
        return response
    }
    
    private func jsonWithOnlyLatitudeAndLongitudeResponse() -> String {
        var response = ""
        response += "{\"latitude\":\"45.463688\",\"longitude\":\"9.188141\"}"
        return response
    }
    
    static var allTests: [(String, (LocationTests) -> () throws -> Void)] {
        return [
            ("testConstants", testConstants),
            ("testUtils", testUtils),
            ("testCityConstructor", testCityConstructor),
            ("testLatitudeAndLongitude", testLatitudeAndLongitude),
            ("testNameAndCode", testNameAndCode),
            ("testDistanceToCity", testDistanceToCity),
            ("testDistanceRomeAndMilan", testDistanceRomeAndMilan),
            ("testMakeJsonWithOnlyLatitudeAndLongitude", testMakeJsonWithOnlyLatitudeAndLongitude),
            ("testMakeJsonWithAll", testMakeJsonWithAll),
            ("testCustomStringConvertibleLong", testCustomStringConvertibleLong),
            ("testCustomStringConvertibleShort", testCustomStringConvertibleShort)
        ]
    }

    
}

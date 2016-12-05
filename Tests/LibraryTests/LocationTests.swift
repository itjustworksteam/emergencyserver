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
        let _ = City(latitude: 1.0, longitude: 1.0)
        let _ = City(latitude: 1.0, longitude: 1.0, name: "Name", asciiname: "Name", code: "IT")
    }
    
    func testJSONCity() {
        let milan = City(latitude: 45.463688, longitude: 9.188141, name: "Milan", asciiname: "Milan", code: "IT")
        XCTAssertEqual(milanJsonResponse(), milan.makeJson(), "should be equals")
        let cityWithNoName = City(latitude: 45.463688, longitude: 9.188141)
        XCTAssertEqual(cityWithNoNameJsonResponse(), cityWithNoName.makeJson(), "should be equals")
    }
    
    func testDistanceToCity() {
        let milan = City(latitude: 45.463688, longitude: 9.188141)
        let rome = City(latitude: 41.895466, longitude: 12.482324)
        XCTAssertEqualWithAccuracy(476.0, milan.distanceToCity(city: rome), accuracy: 1, "should be equals")
        XCTAssertEqualWithAccuracy(476.0, rome.distanceToCity(city: milan), accuracy: 1, "should be equals")
    }
    
    func testLocation() {
        let city = City(latitude: 1.0, longitude: 1.0)
        let _ = Location(location: city)
        let _ = Location(latitude: 1.0, longitude: 1.0)
    }
    
    func testClosestCity() {
        let myPosition = Location(latitude: 45.650433, longitude: 9.197645)
        XCTAssertEqual(myPositionOutput(), myPosition.getClosestCity().makeJson(), "should be equals")
    }
    
    func testPublicCity() {
        let city = City(latitude: 1.0, longitude: 1.0, name: "Milan", asciiname: "Milan", code: "IT")
        XCTAssertEqual("IT", city.getCode(), "should be equals")
        XCTAssertEqual("Milan", city.getName())
        XCTAssertEqual("Milan", city.getAsciiName())
    }
    
    func testMinMaxValuesForQueryDatabase() {
        // implementare correttamente questo test e il metodo
        let values = Location.returnResults(latitude: 1.0, longitude: 1.0)
        XCTAssertEqual(1.0, values.minLat)
        XCTAssertEqual(1.0, values.maxLat)
        XCTAssertEqual(1.0, values.minLon)
        XCTAssertEqual(1.0, values.maxLon)
    }
    
    private func myPositionOutput() -> String {
        return "{\"name\": \"Milan\", \"asciiname\": \"Milan\", \"code\": \"IT\", \"latitude\": \"45.463688\", \"longitude\": \"9.188141\"}"
    }
    
    private func milanJsonResponse() -> String {
        return "{\"name\": \"Milan\", \"asciiname\": \"Milan\", \"code\": \"IT\", \"latitude\": \"45.463688\", \"longitude\": \"9.188141\"}"
    }
    
    private func cityWithNoNameJsonResponse() -> String {
        return "{\"latitude\": \"45.463688\", \"longitude\": \"9.188141\"}"
    }
    
    static var allTests: [(String, (LocationTests) -> () throws -> Void)] {
        return [
            ("testConstants", testConstants),
            ("testUtils", testUtils),
            ("testCityConstructor", testCityConstructor),
            ("testDistanceToCity", testDistanceToCity),
            ("testLocation", testLocation),
            ("testClosestCity", testClosestCity),
            ("testPublicCity", testPublicCity),
            ("testMinMaxValuesForQueryDatabase", testMinMaxValuesForQueryDatabase)
        ]
    }

    
}

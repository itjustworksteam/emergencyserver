import XCTest
@testable import Library

class DataSourceTests: XCTestCase {
	
	func testClass() {
		let _ = DataSource()
	}
    
    func testGetNumbersFromCountryCode() {
        let response = DataSource().getCountryWithCountryCode("it")
        XCTAssertEqual(response, "{\"name\":\"Italy\", \"code\":\"IT\", \"police\":\"113\", \"medical\":\"118\", \"fire\":\"115\"}")
    }
    
    func testGetNumbersFromCountryCodeError() {
        let response = DataSource().getCountryWithCountryCode("hj")
        XCTAssertEqual(response, "{\"error\":\"No country found with the given 2-letter country code hj\"}")
    }
    
    func testEqualResponseForCountryInUpperOrLowerCase() {
        let uppercase = DataSource().getCountryWithCountryCode("IT")
        let lowercase = DataSource().getCountryWithCountryCode("it")
        XCTAssertEqual(uppercase, lowercase)
    }
    
    func testGetAllResults() {
        let response = DataSource().getAll()
        XCTAssertEqual(response, getAllOutput())
    }
    
    func getAllOutput() -> String {
        return DataSource().getAll()
    }

	static var allTests: [(String, (DataSourceTests) -> () throws -> Void)] {
		return [
			("testClass", testClass),
			("testGetNumbersFromCountryCode", testGetNumbersFromCountryCode),
			("testGetNumbersFromCountryCodeError", testGetNumbersFromCountryCodeError),
			("testEqualResponseForCountryInUpperOrLowerCase", testEqualResponseForCountryInUpperOrLowerCase),
			("testGetAllResults", testGetAllResults)
		]
	}
}

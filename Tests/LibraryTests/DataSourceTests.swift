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
        XCTAssertEqual(response, errorCodeOutput("hj"))
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
    
    func testClosestCity() {
        let response = DataSource().getCountryWithCountryCode("IT", andClosestCity: "Seregno")
        XCTAssertEqual(response, "{\"name\":\"Italy\", \"code\":\"IT\", \"police\":\"113\", \"medical\":\"118\", \"fire\":\"115\", \"closestcity\":\"Seregno\"}")
    }
    
    func testCustomStringConvertible() {
        let country = Country(name: "Italy", code: "IT", police: "112", medical: "118", fire: "115")
        XCTAssertEqual("Country={name=Italy, code=IT, police=112, medical=118, fire=115}", "\(country)")
    }
    
    func testPoliceNumberWithCountryCode() {
        let countryCode = "IT"
        let response = DataSource().getPoliceNumberWithCountryCode(countryCode)
        XCTAssertEqual(policeOutput(), response, "should be equals")
        
        let countryCode1 = "it"
        let response1 = DataSource().getPoliceNumberWithCountryCode(countryCode1)
        XCTAssertEqual(policeOutput(), response1, "should be equals")
        
        let countryCode2 = "hj"
        let response2 = DataSource().getPoliceNumberWithCountryCode(countryCode2)
        XCTAssertEqual(errorCodeOutput(countryCode2), response2, "should be equals")
    }
    
    func testMedicalNumberWithCountryCode() {
        let countryCode = "IT"
        let response = DataSource().getMedicalNumberWithCountryCode(countryCode)
        XCTAssertEqual(medicalOutput(), response, "should be equals")
        
        let countryCode1 = "it"
        let response1 = DataSource().getMedicalNumberWithCountryCode(countryCode1)
        XCTAssertEqual(medicalOutput(), response1, "should be equals")
        
        let countryCode2 = "hj"
        let response2 = DataSource().getMedicalNumberWithCountryCode(countryCode2)
        XCTAssertEqual(errorCodeOutput(countryCode2), response2, "should be equals")
    }
    
    func testFireNumberWithCountryCode() {
        let countryCode = "IT"
        let response = DataSource().getFireNumberWithCountryCode(countryCode)
        XCTAssertEqual(fireOutput(), response, "should be equals")
        
        let countryCode1 = "it"
        let response1 = DataSource().getFireNumberWithCountryCode(countryCode1)
        XCTAssertEqual(fireOutput(), response1, "should be equals")
        
        let countryCode2 = "hj"
        let response2 = DataSource().getFireNumberWithCountryCode(countryCode2)
        XCTAssertEqual(errorCodeOutput(countryCode2), response2, "should be equals")
    }
    
    func policeOutput() -> String {
        return "{\"police\":\"113\"}"
    }
    
    func medicalOutput() -> String {
        return "{\"medical\":\"118\"}"
    }
    
    func fireOutput() -> String {
        return "{\"fire\":\"115\"}"
    }
    
    func errorCodeOutput(_ code: String) -> String {
        return "{\"error\":\"No country found with the given 2-letter country code \(code)\"}"
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
			("testGetAllResults", testGetAllResults),
			("testClosestCity", testClosestCity),
			("testCustomStringConvertible", testCustomStringConvertible),
			("testPoliceNumberWithCountryCode", testPoliceNumberWithCountryCode),
			("testMedicalNumberWithCountryCode", testMedicalNumberWithCountryCode),
			("testFireNumberWithCountryCode", testFireNumberWithCountryCode),
		]
	}
}

import XCTest
@testable import Library

class DataSourceTests: XCTestCase {
	
	func testClass() {
		let _ = DataSource()
	}

	static var allTests: [(String, (DataSourceTests) -> () throws -> Void)] {
		return [
			("testClass", testClass),
		]
	}
}
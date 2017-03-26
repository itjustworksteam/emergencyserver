import Vapor
import HTTP
import Library

final class ApiVersionTwoController {
    
    func addRoutes(drop: Droplet){
        // /api/v2
        let v2 = drop.grouped("api/v2")
        // /api/v2/numbers
        let numbers = v2.grouped("numbers")
        numbers.get("all", handler: getAll)
        numbers.get(String.self, handler: getWithCountryCode)
        numbers.get(String.self, String.self, handler: getWithLatitudeAndLongitude)
    }
    
    // MARK: Version Two Numbers
    // GET /api/v2/numbers/all
    func getAll(request: Request) throws -> ResponseRepresentable {
        return DataSource().getAll()
    }
    
    // GET /api/v2/numbers/:country
    func getWithCountryCode(request: Request, country: String) throws -> ResponseRepresentable {
        return DataSource().getCountryWithCountryCode(country)
    }
    
    // GET /api/v2/numbers/:latitude/:longitude
    func getWithLatitudeAndLongitude(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        let response = try drop.client.get(Emergency.createUrlWithLatitude(latitude, andLongitude: longitude))
        if let countryCode = response.data["countrycode"]?.string, let city = response.data["city"]?.string {
            return DataSource().getCountryWithCountryCode(countryCode, andClosestCity: city)
        }
        return Emergency.noLocationFoundError()
    }
}

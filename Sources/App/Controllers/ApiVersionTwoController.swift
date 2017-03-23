import Vapor
import HTTP
import Library

final class ApiVersionTwoController {
    
    func addRoutes(drop: Droplet){
        let v2 = drop.grouped("api/v2")
        let numbers = v2.grouped("numbers")
        numbers.get("all", handler: getAll)
        numbers.get(String.self, handler: getWithCountryCode)
        numbers.get(String.self, String.self, handler: getWithLatitudeAndLongitude)
    }
    
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

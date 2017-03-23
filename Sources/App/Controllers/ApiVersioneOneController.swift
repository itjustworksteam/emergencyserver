import Vapor
import HTTP
import Library

final class ApiVersioneOneController {
    
    func addRoutes(drop: Droplet) {
        let api = drop.grouped("api")
        // GET /api/all
        api.get("all", handler: getAll)
        // GET /api/:country
        api.get(String.self, handler: getWithCountryCode)
        // GET /api/:latitude/:longitude
        api.get(String.self, String.self, handler: getWithLatitudeAndLongitude)
    }
    
    // MARK: /api/all
    func getAll(request: Request) throws -> ResponseRepresentable {
        return DataSource().getAll()
    }
    
    // MARK: /api/:country
    func getWithCountryCode(request: Request, country: String) throws -> ResponseRepresentable {
        return DataSource().getCountryWithCountryCode(country)
    }
    
    // http://scatter-otl.rhcloud.com/location?lat=45.650433&long=9.197645
    
    // MARK: /api/:latitude/:longitude
    func getWithLatitudeAndLongitude(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        let response = try drop.client.get(Emergency.createUrlWithLatitude(latitude, andLongitude: longitude))
        if let countrycode = response.data["countrycode"]?.string, let city = response.data["city"]?.string {
            return DataSource().getCountryWithCountryCode(countrycode, andClosestCity: city)
        }
        return Emergency.noLocationFoundError()
    }
}

public struct Emergency {
    public static func createUrlWithLatitude(_ latitude: String, andLongitude longitude: String) -> String {
        return "http://scatter-otl.rhcloud.com/location?lat=\(latitude)&long=\(longitude)"
    }
    
    public static func noLocationFoundError() -> String {
        return "{\"error\":\"Sorry cannot get your location. Retry!\"}"
    }

}

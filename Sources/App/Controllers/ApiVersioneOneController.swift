import Vapor
import HTTP
import Library

final class ApiVersioneOneController {
    
    private var logger: LogProtocol?
    
    private func logMessage(_ message: String) {
        if self.logger != nil {
            self.logger?.debug(message)
        }
    }
    
    func addRoutes(drop: Droplet) {
        self.logger = drop.log
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
        let response = DataSource().getAll()
        logMessage(response)
        return response
    }
    
    // MARK: /api/:country
    func getWithCountryCode(request: Request, country: String) throws -> ResponseRepresentable {
        let response = DataSource().getCountryWithCountryCode(country)
        logMessage(response)
        return response
    }
    
    // https://emergency-server-backend.herokuapp.com/location?lat=36&long=-78.9
    
    // MARK: /api/:latitude/:longitude
    func getWithLatitudeAndLongitude(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        let response = try drop.client.get(Emergency.createUrlWithLatitude(latitude, andLongitude: longitude))
        logMessage(response.description)
        if let countrycode = response.data["countrycode"]?.string, let city = response.data["city"]?.string {
            let reply = DataSource().getCountryWithCountryCode(countrycode, andClosestCity: city)
            logMessage(reply)
            return reply
        }
        logMessage(Emergency.noLocationFoundError())
        return Emergency.noLocationFoundError()
    }
}

public struct Emergency {
    public static func createUrlWithLatitude(_ latitude: String, andLongitude longitude: String) -> String {
        return "https://emergency-server-backend.herokuapp.com/location?lat=\(latitude)&long=\(longitude)"
    }
    
    public static func noLocationFoundError() -> String {
        return "{\"error\":\"Sorry cannot get your location. Retry!\"}"
    }

}

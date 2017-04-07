import Vapor
import HTTP
import Library

final class ApiVersionTwoController {
    
    private var logger: LogProtocol?
    
    private func logMessage(_ message: String){
        if self.logger != nil {
            self.logger?.debug(message)
        }
    }
    
    func addRoutes(drop: Droplet){
        // /api/v2
        self.logger = drop.log
        let v2 = drop.grouped("api/v2")
        // /api/v2/numbers
        let numbers = v2.grouped("numbers")
        numbers.get("all", handler: getAll)
        numbers.get(String.self, handler: getWithCountryCode)
        numbers.get(String.self, String.self, handler: getWithLatitudeAndLongitude)
        
        // /api/v2/city
        let city = v2.grouped("city")
        city.get(String.self, String.self, handler: getClosestCity)
        
        // /api/v2/police
        let police = v2.grouped("police")
        police.get(String.self, handler: getPoliceWithCountryCode)
        police.get(String.self, String.self, handler: getPoliceWithLatitudeAndLongitude)
        
        // /api/v2/fire
        let fire = v2.grouped("fire")
        fire.get(String.self, handler: getFireWithCountryCode)
        fire.get(String.self, String.self, handler: getFireWithLatitudeAndLongitude)
        
        // /api/v2/medical
        let medical = v2.grouped("medical")
        medical.get(String.self, handler: getMedicalWithCountryCode)
        medical.get(String.self, String.self, handler: getMedicalWithLatitudeAndLongitude)
    }
    
    // MARK: Version Two Numbers
    // GET /api/v2/numbers/all
    func getAll(request: Request) throws -> ResponseRepresentable {
        let response = DataSource().getAll()
        logMessage(response)
        return response
    }
    
    // GET /api/v2/numbers/:country
    func getWithCountryCode(request: Request, country: String) throws -> ResponseRepresentable {
        let response = DataSource().getCountryWithCountryCode(country)
        logMessage(response)
        return response
    }
    
    // GET /api/v2/numbers/:latitude/:longitude
    func getWithLatitudeAndLongitude(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        let response = try drop.client.get(Emergency.createUrlWithLatitude(latitude, andLongitude: longitude))
        logMessage(response.description)
        if let countryCode = response.data["countrycode"]?.string, let city = response.data["city"]?.string {
            let reply = DataSource().getCountryWithCountryCode(countryCode, andClosestCity: city)
            logMessage(reply)
            return reply
        }
        logMessage(Emergency.noLocationFoundError())
        return Emergency.noLocationFoundError()
    }
    
    // GET /api/v2/city/:latitude/:longitude
    func getClosestCity(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        let response = try drop.client.get(Emergency.createUrlWithLatitude(latitude, andLongitude: longitude))
        logMessage(response.description)
        if let countrycode = response.data["countrycode"]?.string, let city = response.data["city"]?.string, let lat = response.data["latitude"]?.double, let lon = response.data["longitude"]?.double {
            let reply = City(latitude: lat, longitude: lon, name: city, code: countrycode)
            logMessage(reply.description)
            return reply.makeJson()
        }
        logMessage(Emergency.noLocationFoundError())
        return Emergency.noLocationFoundError()
    }
    
    // GET /api/v2/police/:country
    func getPoliceWithCountryCode(request: Request, code: String) throws -> ResponseRepresentable {
        let response = DataSource().getPoliceNumberWithCountryCode(code)
        logMessage(response)
        return response
    }
    
    // GET /api/v2/police/:latitude/:longitude
    func getPoliceWithLatitudeAndLongitude(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        let response = try drop.client.get(Emergency.createUrlWithLatitude(latitude, andLongitude: longitude))
        logMessage(response.description)
        if let code = response.data["countrycode"]?.string {
            let reply = DataSource().getPoliceNumberWithCountryCode(code)
            logMessage(reply)
            return reply
        }
        logMessage(Emergency.noLocationFoundError())
        return Emergency.noLocationFoundError()
    }
    
    // GET /api/v2/fire/:country
    func getFireWithCountryCode(request: Request, code: String) throws -> ResponseRepresentable {
        let response = DataSource().getFireNumberWithCountryCode(code)
        logMessage(response)
        return response
    }
    
    // GET /api/v2/fire/:latitude/:longitude
    func getFireWithLatitudeAndLongitude(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        let response = try drop.client.get(Emergency.createUrlWithLatitude(latitude, andLongitude: longitude))
        logMessage(response.description)
        if let code = response.data["countrycode"]?.string {
            let reply = DataSource().getFireNumberWithCountryCode(code)
            logMessage(reply)
            return reply
        }
        logMessage(Emergency.noLocationFoundError())
        return Emergency.noLocationFoundError()
    }
    
    // GET /api/v2/medical/:country
    func getMedicalWithCountryCode(request: Request, code: String) throws -> ResponseRepresentable {
        let response = DataSource().getMedicalNumberWithCountryCode(code)
        logMessage(response)
        return response
    }
    
    // GET /api/v2/medical/:latitude/:longitude
    func getMedicalWithLatitudeAndLongitude(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        let response = try drop.client.get(Emergency.createUrlWithLatitude(latitude, andLongitude: longitude))
        logMessage(response.description)
        if let code = response.data["countrycode"]?.string {
            let reply = DataSource().getMedicalNumberWithCountryCode(code)
            logMessage(reply)
            return reply
        }
        logMessage(Emergency.noLocationFoundError())
        return Emergency.noLocationFoundError()
    }
}

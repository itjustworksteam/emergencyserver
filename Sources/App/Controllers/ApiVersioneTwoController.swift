import Vapor
import HTTP
import Library

struct DataBase {
    static let Host = "127.0.0.1"
    static let User = "root"
    static let Password = "password"
    static let Database = "emergencydata"
}

// get the database info from the command line arguments
//let host = drop.config["cli", "host"]?.string
//let user = drop.config["cli", "user"]?.string
//let password = drop.config["cli", "password"]?.string
//let database = drop.config["cli", "database"]?.string

final class ApiVersioneTwoController {
    
    func addRoutes(drop: Droplet) {
        let api = drop.grouped("api/v2")
        api.get("test", handler: test)
        //api.get("numbers", String.self, String.self, handler: numbers)
    }
    
    func test(request: Request) throws -> ResponseRepresentable {
        return "Test"
    }
    
    // MARK: /api/v2/numbers/:latitude/:longitude
    // this method will return the emergency numbers of the country
    /*
    func numbers(request: Request, latitude: String, longitude: String) throws -> ResponseRepresentable {
        if let lat = Double(latitude), let lon = Double(longitude) {
            let city = Location(latitude: lat, longitude: lon).usingDatabase(host: DataBase.Host, user: DataBase.User, password: DataBase.Password, database: DataBase.Database).getClosestCity()
            return DataSource().getCountryWithID(countryCode: city.getCode())
        }
        throw Abort.custom(status: .badRequest, message: "Please provide real location")
    }
    */
    // MARK: /api/v2/city/:latitude/:longitude
    // this method will return the closest city
    
    // MARK: /api/v2/numbers/all
    // this method will return all the emergency numbers
    
    // MARK: /api/v2/numbers/:code
    // this method will return the emergency numbers of the country
    
}

import Vapor
import HTTP
import Library

// MARK: Create Droplet
let drop = Droplet()

// MARK: Navigation
drop.get("/") { _ in
    return Response(redirect: "/api")
}

drop.get("/api") { _ in
    return try drop.view.make("api.html")
}

// MARK: API Version 1 Working
drop.get("/api/", String.self) { request, countryCode in
    return DataSource().getCountryWithID(countryCode: countryCode)
}

drop.get("/api/all") { _ in 
    return DataSource().getAll()
}

drop.get("/api/", String.self, String.self) { request, latitude, longitude in
    let response = try drop.client.get("http://scatter-otl.rhcloud.com/location?lat=\(latitude)&long=\(longitude)")
    if let countrycode = response.data["countrycode"]?.string {
        return DataSource().getCountryWithID(countryCode: countrycode)
    }
    return "{\"error\":\"Sorry cannot get your location. Retry!\"}"
}

// MARK: API Version 2 Still a work in progress

// get the database info
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

drop.get("/api/v2/location/", String.self, String.self) { request, latitude, longitude in
    if let lat = Double(latitude), let lon = Double(longitude) {
        let city = Location(latitude: lat, longitude: lon).usingDatabase(host: DataBase.Host, user: DataBase.User, password: DataBase.Password, database: DataBase.Database).getClosestCity()
        return DataSource().getCountryWithID(countryCode: city.getCode())
    }
    throw Abort.custom(status: .badRequest, message: "Please provide real location")
}


drop.run()

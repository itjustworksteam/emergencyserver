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

//drop.get("/api/v2/location/", String.self, String.self) { request, latitude, longitude in
//    if let lat = Double(latitude), let lon = Double(longitude) {
//        let city = Location(latitude: lat, longitude: lon).getClosestCity()
//        return DataSource().getCountryWithID(countryCode: city.getCode())
//    }
//    throw Abort.custom(status: .badRequest, message: "Please provide real location")
//}


drop.run()

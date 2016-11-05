import Vapor
import HTTP

let drop = Droplet()

drop.get("/") { _ in
    return Response(redirect: "/api")
}

drop.get("/api/", String.self) { request, countryCode in
    let response = try drop.client.get("https://emergency-phone-numbers.herokuapp.com/country/\(countryCode)")
    return response
}

drop.get("/api/", String.self, String.self) { request, latitude, longitude in
    let response = try drop.client.get("http://scatter-otl.rhcloud.com/location?lat=\(latitude)&long=\(longitude)")
    if let countrycode = response.data["countrycode"]?.string {
        let response = try drop.client.get("https://emergency-phone-numbers.herokuapp.com/country/\(countrycode)")
        return response
    }
    return "not found"
}

drop.get("/api") { _ in
    return try drop.view.make("api.html")
}

drop.run()

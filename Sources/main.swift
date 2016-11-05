import Vapor

let drop = Droplet()

drop.get("/") { _ in
  return "It Just Works Team"
}

drop.get("/api/", String.self) { request, countryCode in
    let response = try drop.client.get("https://emergency-phone-numbers.herokuapp.com/country/\(countryCode)")
    return response
}

drop.get("/api/", String.self, String.self) { request, latitude, longitude in
    let response = try drop.client.get("http://scatter-otl.rhcloud.com/location?lat=\(latitude)&long=\(longitude)")
    return response
}

drop.run()

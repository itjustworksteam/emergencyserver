public class City {
    
    private var latitude: Double
    private var longitude: Double
    private var name: String?
    private var asciiname: String?
    private var code: String?
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience init(latitude: Double, longitude: Double, name: String, asciiname: String, code: String) {
        self.init(latitude: latitude, longitude: longitude)
        self.name = name
        self.asciiname = asciiname
        self.code = code
    }
    
    public func getCode() -> String {
        return self.code != nil ? self.code! : "not found"
    }
    
    public func getName() -> String {
        return self.name != nil ? self.name! : "not found"
    }
    
    public func getAsciiName() -> String {
        return self.asciiname != nil ? self.asciiname! : "not found"
    }
    
    public func makeJson() -> String {
        if self.name != nil && self.asciiname != nil && self.code != nil {
            return "{\"name\": \"\(self.name!)\", \"asciiname\": \"\(self.asciiname!)\", \"code\": \"\(self.code!)\", \"latitude\": \"\(self.latitude)\", \"longitude\": \"\(self.longitude)\"}"
        }
        return "{\"latitude\": \"\(self.latitude)\", \"longitude\": \"\(self.longitude)\"}"
    }
    
    func distanceToCity(city: City) -> Double {
        return Utils.disgeod(latA: self.latitude, lonA: self.longitude, latB: city.latitude, lonB: city.longitude)
    }
    
}

public class City {
    
    public var latitude: Double {
        get {
            return self._latitude
        }
    }
    private var _latitude: Double
    public var longitude: Double {
        get {
            return self._longitude
        }
    }
    private var _longitude: Double
    public var name: String? {
        get {
            return self._name
        }
    }
    private var _name: String?
    public var code: String? {
        get {
            return self._code
        }
    }
    private var _code: String?
    
    init(latitude: Double, longitude: Double) {
        self._latitude = latitude
        self._longitude = longitude
    }
    
    convenience init(latitude: Double, longitude: Double, name: String, code: String) {
        self.init(latitude: latitude, longitude: longitude)
        self._name = name
        self._code = code
    }
    
    
    public func makeJson() -> String {
        if self._name != nil && self._code != nil {
            return "{\"latitude\":\(self.latitude),\"longitude\":\(self.longitude),\"city\":\"\(self._name!)\",\"code\":\"\(self._code!)\"}"
        }
        return "{\"latitude\":\(self.latitude),\"longitude\":\(self.longitude)}"
    }
    
    func distanceToCity(_ city: City) -> Double {
        return Utils.disgeod(latA: self.latitude, lonA: self.longitude, latB: city.latitude, lonB: city.longitude)
    }
    
}

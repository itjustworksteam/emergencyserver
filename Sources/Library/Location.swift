class Location {
    
    private var location: City
    private var closestCity: City?
    
    init(location: City) {
        self.location = location
    }
    
    init(latitude: Double, longitude: Double) {
        self.location = City(latitude: latitude, longitude: longitude)
    }
    
    func getClosestCity() -> String {
        var minimalDistance = 123456789.0
        var distance: Double
        for i in 0..<source.count {
            distance = self.location.distanceToCity(city: source[i])
            if distance < minimalDistance {
                minimalDistance = distance
                self.closestCity = source[i]
            }
        }
        return self.closestCity != nil ? self.closestCity!.makeJson() : "not found"
    }
    
    private
    let source = [City(latitude: 45.463688, longitude: 9.188141, name: "Milan", asciiname: "Milan", code: "IT").self,
                  City(latitude: 41.895466, longitude: 12.482324, name: "Rome", asciiname: "Rome", code: "IT").self]
    
}

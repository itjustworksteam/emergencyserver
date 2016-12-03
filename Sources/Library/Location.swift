public class Location {
    
    private var location: City
    private var closestCity: City?
    private var sources = [City]()
    
    init(location: City) {
        self.location = location
        self.populateSourcesArrayFromDatabase()
    }
    
    public init(latitude: Double, longitude: Double) {
        self.location = City(latitude: latitude, longitude: longitude)
        self.populateSourcesArrayFromDatabase()
    }
    
    public func getClosestCity() -> City {
        var minimalDistance = 123456789.0
        var distance: Double
        if self.sources.count > 0 {
            for i in 0..<sources.count {
                distance = self.location.distanceToCity(city: sources[i])
                if distance < minimalDistance {
                    minimalDistance = distance
                    self.closestCity = sources[i]
                }
            }
        } else {
            for i in 0..<source.count {
                distance = self.location.distanceToCity(city: source[i])
                if distance < minimalDistance {
                    minimalDistance = distance
                    self.closestCity = source[i]
                }
            }
        }
        return self.closestCity!
    }
    
    private func populateSourcesArrayFromDatabase() {
        // working on it
    }
    
    private
    let source = [City(latitude: 45.463688, longitude: 9.188141, name: "Milan", asciiname: "Milan", code: "IT").self,
                  City(latitude: 41.895466, longitude: 12.482324, name: "Rome", asciiname: "Rome", code: "IT").self]
    
}

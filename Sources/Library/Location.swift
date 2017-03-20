/*
import MySQL

public class Location {
    
    private var location: City
    private var closestCity: City?
    private var sources = [City]()
    private var mysql: Database?
    
    init(location: City) {
        self.location = location
    }
    
    public func usingDatabase(host: String, user: String, password: String, database: String) -> Location {
        do {
            self.mysql = try MySQL.Database(host: host, user: user, password: password, database: database)
            try self.populateSourcesArrayFromDatabase()
        } catch {
            self.mysql = nil
        }
        return self
    }
    
    public convenience init(latitude: Double, longitude: Double) {
        self.init(location: City(latitude: latitude, longitude: longitude))
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
            for i in 0..<sourceForTestingOnly.count {
                distance = self.location.distanceToCity(city: sourceForTestingOnly[i])
                if distance < minimalDistance {
                    minimalDistance = distance
                    self.closestCity = sourceForTestingOnly[i]
                }
            }
        }
        return self.closestCity!
    }
    
    static func returnResults(latitude: Double, longitude: Double) -> (minLat: Double, maxLat: Double, minLon: Double, maxLon: Double) {
        let interval = 0.5
        let minLat = latitude - interval
        let maxLat = latitude + interval
        let minLon = longitude - interval
        let maxLon = longitude + interval
        return (minLat, maxLat, minLon, maxLon)
    }
    
    private func populateSourcesArrayFromDatabase() throws {
        if let db = self.mysql {
            let values = Location.returnResults(latitude: self.location.getLatitude(), longitude: self.location.getLongitude())
            let results = try db.execute("SELECT * FROM location WHERE latitude BETWEEN ? AND ? AND longitude BETWEEN ? AND ?", [values.minLat, values.maxLat, values.minLon, values.maxLon])
            for result in results {
                self.sources.append(City(latitude: (result["latitude"]?.double!)!, longitude: (result["longitude"]?.double!)!, name: (result["name"]?.string!)!, asciiname: (result["asciiname"]?.string!)!, code: (result["countrycode"]?.string!)!))
            }
            print(self.sources.count)
        }
    }
    
    private
    let sourceForTestingOnly = [City(latitude: 45.463688, longitude: 9.188141, name: "Milan", asciiname: "Milan", code: "IT").self,
                  City(latitude: 41.895466, longitude: 12.482324, name: "Rome", asciiname: "Rome", code: "IT").self]
    
}
*/

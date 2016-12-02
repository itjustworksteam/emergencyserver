#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

struct Constants {
    static let PI = 3.1415
    static let EarthRadius = 6371.0
    static let StraightAngle = 180.0
}

class Utils {
    
    static func gradToRad(grad: Double) -> Double {
        return Constants.PI * grad / Constants.StraightAngle
    }
    
    static func disgeod(latA: Double, lonA: Double, latB: Double, lonB: Double) -> Double {
        let lat_alfa = Utils.gradToRad(grad: latA)
        let lon_alfa = Utils.gradToRad(grad: lonA)
        let lat_beta = Utils.gradToRad(grad: latB)
        let lon_beta = Utils.gradToRad(grad: lonB)
        let fi = fabs(lon_alfa - lon_beta)
        let p = acos(sin(lat_beta) * sin(lat_alfa) + cos(lat_beta) * cos(lat_alfa) * cos(fi))
        return p * Constants.EarthRadius
    }
    
}

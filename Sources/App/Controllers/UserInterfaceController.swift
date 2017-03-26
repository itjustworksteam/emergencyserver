import Vapor
import HTTP

final class UserInterfaceController {
    
    func addRoutes(drop: Droplet) {
        let root = drop.grouped("/")
        root.get("", handler: index)
        root.get("developers", handler: developers)
    }
    
    // MARK: Index Page
    func index(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("index")
    }
    
    private let DEFAULT_URL = "https://emergency-server.herokuapp.com"
    
    // MARK: Developer Page
    func developers(request: Request) throws -> ResponseRepresentable {
        let apiOnes = try [
            ["endpoint":"GET /api/all", "description":"Return a JSON array with Country objects.", "example":"\(DEFAULT_URL)/api/all"].makeNode(),
            ["endpoint":"GET /api/:country", "description":"Return a JSON object with a Country object.", "example":"\(DEFAULT_URL)/api/it"].makeNode(),
            ["endpoint":"GET /api/:latitude/:longitude", "description":"Return a JSON object with a Country object plus a \"closestcity\" field that is the closest city.", "example":"\(DEFAULT_URL)/api/45.0/9.0"].makeNode()
        ].makeNode()
        
        let apiTwos = try [
            ["endpoint":"GET /api/v2/numbers/all", "description":"Return a JSON array with Country objects.", "example":"\(DEFAULT_URL)/api/v2/numbers/all"].makeNode(),
            ["endpoint":"GET /api/v2/numbers/:country", "description":"Return a JSON object with a Country object.", "example":"\(DEFAULT_URL)/api/v2/numbers/it"].makeNode(),
            ["endpoint":"GET /api/v2/numbers/:latitude/:longitude", "description":"Return a JSON object with a Country object plus a \"closestcity\" field that is the closest city.", "example":"\(DEFAULT_URL)/api/v2/numbers/45.0/9.0"].makeNode()
            ].makeNode()
        
        return try drop.view.make("api", Node(["apiOnes":apiOnes, "apiTwos":apiTwos]))
    }
    
}

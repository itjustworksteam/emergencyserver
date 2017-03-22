import Vapor
import HTTP
import Library

final class ApiVersioneTwoController {
    
    func addRoutes(drop: Droplet) {
        let api = drop.grouped("api/v2")
        api.get("test", handler: test)
    }
    
    func test(request: Request) throws -> ResponseRepresentable {
        return "API Version Two Not Created Yet"
    }
    
}

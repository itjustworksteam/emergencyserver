import Vapor
import HTTP

final class UserInterfaceController {
    
    func addRoutes(drop: Droplet) {
        let root = drop.grouped("/")
        root.get("", handler: index)
        root.get("developers", handler: developers)
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        return Response(redirect: "/developers")
    }
    
    func developers(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("api.html")
    }
    
}

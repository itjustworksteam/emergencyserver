import Vapor
import HTTP
import Library

// MARK: Create Droplet
let drop = Droplet()

// MARK: User Interface
let userInterface = UserInterfaceController()
userInterface.addRoutes(drop: drop)

// MARK: API Version 1 Working
let apiVersionOne = ApiVersioneOneController()
apiVersionOne.addRoutes(drop: drop)

// MARK: API Version 2 Still A Work In Progress
let apiVersioneTwo = ApiVersioneTwoController()
apiVersioneTwo.addRoutes(drop: drop)

drop.run()

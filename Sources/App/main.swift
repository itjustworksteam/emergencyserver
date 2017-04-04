import Vapor
import HTTP
import Library
import SwiftyBeaverVapor
import SwiftyBeaver

// MARK: Configure Logger
let console = ConsoleDestination()
let loggerProvider = SwiftyBeaverProvider(destinations: [console])

// MARK: Create Droplet
let drop = Droplet()
drop.addProvider(loggerProvider)

// MARK: If Debug mode is On
//(drop.view as? LeafRenderer)?.stem.cache = nil

// MARK: User Interface
let userInterface = UserInterfaceController()
userInterface.addRoutes(drop: drop)

// MARK: API Version 1 Working
let apiVersionOne = ApiVersioneOneController()
apiVersionOne.addRoutes(drop: drop)

// MARK: API Version 2 Work In Progress
let apiVersionTwo = ApiVersionTwoController()
apiVersionTwo.addRoutes(drop: drop)

drop.run()

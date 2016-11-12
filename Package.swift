import PackageDescription

let package = Package(
    name: "emergencyserver",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 1)
    ]
)

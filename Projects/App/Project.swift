import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "babya",
    packages: [
        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.9.1")),
        .remote(url: "https://github.com/Alamofire/AlamofireImage", requirement: .upToNextMajor(from: "4.3.0"))
    ],
    targets: [
        Target(
            name: "babya",
            platform: .iOS,
            product: .app,
            bundleId: "kr.hs.dgsw.dongbao.babya",
            infoPlist: .file(path: "Support/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [.package(product: "Alamofire"), .package(product: "AlamofireImage")]
        )
    ]
)


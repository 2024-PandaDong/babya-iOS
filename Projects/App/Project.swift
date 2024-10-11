import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "babya",
    packages: [
        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.9.1")),
        .remote(url: "https://github.com/Alamofire/AlamofireImage", requirement: .upToNextMajor(from: "4.3.0")),
        .remote(url: "https://github.com/NuPlay/RichText", requirement: .upToNextMajor(from: "2.0.0"))
    ], 
    settings: .settings(
        configurations: [
            .debug(name: "babya"),
            .release(name: "babya")
        ]
    ),
    targets: [
        Target(
            name: "babya",
            platform: .iOS,
            product: .app,
            bundleId: "kr.hs.dgsw.dongbao.babya",
            infoPlist: .file(path: "Support/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [.package(product: "Alamofire"), .package(product: "AlamofireImage"), .package(product: "RichText")]
        )
    ],
    schemes: [
        Scheme(
            name: "Babya-Debug",
            shared: true,
            buildAction: .buildAction(targets: ["Babya"]),
            archiveAction: .archiveAction(configuration: .debug),
            profileAction: .profileAction(configuration: .debug),
            analyzeAction: .analyzeAction(configuration: .debug)
        ),
        Scheme(
            name: "Babya-Release",
            shared: true,
            buildAction: .buildAction(targets: ["Babya"]),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: .profileAction(configuration: .release),
            analyzeAction: .analyzeAction(configuration: .release)
        )
    ]
)


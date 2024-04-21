import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "babya",
    platform: .iOS,
    product: .app,
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)


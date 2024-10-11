import ProjectDescription

public enum BuildTarget: String {
    case dev = "DEV"
    case rel = "REL"
    
    public var configurationName: ConfigurationName {
        return ConfigurationName.configuration(self.rawValue)
    }
    
}

extension Path {
    public static func relativeToXCConfig(type: BuildTarget) -> Self {
        return .relativeToRoot("./babya/XCConfig/\(type.rawValue.lowercased()).xcconfig")
    }
}

extension Configuration {
    public static func build(_ type: BuildTarget, name: String = "") -> Self {
        let buildName = type.rawValue
        switch type {
        case .dev:
            return .debug(
                name: BuildTarget.dev.configurationName,
                xcconfig: .relativeToXCConfig(type: .dev)
            )
        case .rel:
            return .release(
                name: BuildTarget.rel.configurationName,
                xcconfig: .relativeToXCConfig(type: .rel)
            )
        }
    }
}

extension Scheme {
    
    public static func makeScheme(_ type: BuildTarget, name: String) -> Self {
        let buildName = type.rawValue
        switch type {
        case .dev:
            return Scheme(
                name: "\(name)-\(buildName.uppercased())",
                buildAction: BuildAction(targets: ["\(name)"]),
                runAction: .runAction(configuration: type.configurationName),
                archiveAction: .archiveAction(configuration: type.configurationName),
                profileAction: .profileAction(configuration: type.configurationName),
                analyzeAction: .analyzeAction(configuration: type.configurationName)
            )
        case .rel:
            return Scheme(
                name: "\(name)-\(buildName.uppercased())",
                buildAction: BuildAction(targets: ["\(name)"]),
                runAction: .runAction(configuration: type.configurationName),
                archiveAction: .archiveAction(configuration: type.configurationName),
                profileAction: .profileAction(configuration: type.configurationName),
                analyzeAction: .analyzeAction(configuration: type.configurationName)
            )
        }
    }
}

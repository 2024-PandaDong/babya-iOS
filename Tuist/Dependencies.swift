//
//  Dependencies.swift
//  Manifests
//
//  Created by dgsw8th61 on 5/9/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: [
        .remote(
            url: "https://github.com/Alamofire/Alamofire",
            requirement: .upToNextMajor(from: "5.9.1")
        )
    ],
    platforms: [.iOS]
)

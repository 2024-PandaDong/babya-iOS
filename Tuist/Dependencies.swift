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
        ),
        .remote(
            url: "https://github.com/NuPlay/RichText",
            requirement: .upToNextMajor(from: "2.0.0")
        ),
        .remote(
            url: "https://github.com/Mercen-Lee/FlowKit",
            requirement: .branch("main")
        ),
        .remote(
            url: "https://github.com/onevcat/Kingfisher",
            requirement: .upToNextMajor(from: "8.0.0")
        ),
        .remote(
            url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM",
            requirement: .upToNextMajor(from: "2.12.0")
        )
    ],
    platforms: [.iOS]
)

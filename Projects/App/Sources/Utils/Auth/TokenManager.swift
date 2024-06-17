//
//  TokenManager.swift
//  babya
//
//  Created by hyk on 6/17/24.
//

import Foundation
import SwiftUI

fileprivate let authCache = AuthCache.live

@MainActor
public class TokenManager: ObservableObject {
    
    @Published public var accessToken: String {
        didSet {
            authCache.saveToken(accessToken, to: .accessToken)
        }
    }
    
    @Published public var refreshToken: String {
        didSet {
            authCache.saveToken(refreshToken, to: .refreshToken)
        }
    }

    public init() {
        accessToken = authCache.getToken(of: .accessToken)
        refreshToken = authCache.getToken(of: .refreshToken)
    }
}

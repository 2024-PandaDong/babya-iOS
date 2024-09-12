//
//  TabItem.swift
//  babya
//
//  Created by hyk on 9/11/24.
//

import SwiftUI

enum TabItem {
    case company
    case policy
    case diary
    case todo
    case profile
    
    @ViewBuilder var view: some View {
        switch self {
        case .company:
            CompanySearchView()
        case .policy:
            PolicyView()
        case .diary:
            DiaryView()
        case .todo:
            TodoListView()
        case .profile:
            ProfileView()
        }
    }
}

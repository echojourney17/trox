//
//  TabItem.swift
//  odola-app
//
//  Created by Александр on 27.09.2024.
//

import Foundation
import UIKit

enum TabItem {
    case home
    case data
    case settings
    
    var icon: UIImage {
        switch self {
            case .home:
                return Asset.tabHome.image
            case .data:
                return Asset.tabData.image
            case .settings:
                return Asset.tabMore.image
        }
    }
    
    var title: String {
        switch self {
            case .home:
                return "Data"
            case .data:
                return "VPN"
            case .settings:
                return "Settings"
        }
    }
}

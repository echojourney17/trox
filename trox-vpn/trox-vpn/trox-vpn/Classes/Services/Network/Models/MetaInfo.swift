import Foundation
import UIKit

struct MetaInfo: Codable {
    var ip: String?
    var postal: String?
    var country: String?
    var city: String?
    
    func toItems() -> [MetaInfoDTO] {
        let ip = MetaInfoDTO(item: .ip, dataString: self.ip ?? "-")
        let location = MetaInfoDTO(item: .location, dataString: self.city ?? "-")
        let postal = MetaInfoDTO(item: .postal, dataString: self.postal ?? "-")
        let country = MetaInfoDTO(item: .country, dataString: self.country ?? "-")
        return [ip, location, postal, country]
    }
    
}

struct MetaInfoDTO {
    var item: MetaItem
    var dataString: String
}

enum MetaItem: CaseIterable {
    case ip
    case location
    case postal
    case country
    
    var icon: UIImage? {
        switch self {
        case .ip:
            return Asset.settingsIp.image
        case .location:
            return Asset.settingsLocations.image
        case .postal:
            return Asset.settingsPostal.image
        case .country:
            return Asset.settingsCountry.image
        }
    }
    var title: String {
        switch self {
            case .ip:
                return "IP Address"
            case .location:
                return "Location"
            case .postal:
                return "Postal Code"
            case .country:
                return "Country Code"
        }
    }
}

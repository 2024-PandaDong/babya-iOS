import Foundation
import CoreLocation

struct HospitalResponse: Codable {
    var documents: [Document]?
    var meta: Meta?
}

struct Document: Codable {
    var address_name: String?
    var category_group_code: String?
    var category_group_name: String?
    var category_name: String?
    var distance: String?
    var id: String?
    var phone: String?
    var place_name: String?
    var place_url: String?
    var road_address_name: String?
    var x: String?
    var y: String?
}

struct Meta: Codable {
    var is_end: Bool?
    var pageable_count: Int?
    var same_name: SameName?
    var total_count: Int?
}

struct SameName: Codable {
    var keyword: String?
    var region: [String]?
    var selected_region: String?
}

struct Place: Identifiable {
    var id = UUID()
    var location: CLLocationCoordinate2D
    var name: String
}

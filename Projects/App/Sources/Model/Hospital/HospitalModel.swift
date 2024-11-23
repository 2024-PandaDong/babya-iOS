import Foundation

struct HospitalModel: Codable {
    var documents: [Place] = []
}

struct Place: Codable {
    var place_name: String = ""
    var road_address_name: String?
    var distance: String = ""
    var x: String = ""
    var y: String = ""
}

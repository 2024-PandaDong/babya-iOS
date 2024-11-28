import Foundation

// 병원 데이터 모델
struct HospitalResponse: Codable {
    var documents: [Document]? // 병원 목록
    var meta: Meta?       // 메타 정보
}

// 각 병원에 대한 모델
struct Document: Codable {
    var address_name: String?   // 주소 (옵셔널)
    var category_group_code: String?  // 카테고리 그룹 코드 (옵셔널)
    var category_group_name: String?  // 카테고리 그룹 이름 (옵셔널)
    var category_name: String?  // 카테고리 이름 (옵셔널)
    var distance: String?         // 거리 (옵셔널)
    var id: String?               // ID (옵셔널)
    var phone: String?         // 전화번호 (옵셔널)
    var place_name: String?     // 장소 이름 (옵셔널)
    var place_url: String?      // 장소 URL (옵셔널)
    var road_address_name: String?   // 도로명 주소 (옵셔널)
    var x: String?             // x 좌표 (옵셔널)
    var y: String?             // y 좌표 (옵셔널)
}

// 응답의 메타 정보 모델
struct Meta: Codable {
    var is_end: Bool?          // is_end (옵셔널)
    var pageable_count: Int?   // 페이지 수 (옵셔널)
    var same_name: SameName?   // 동일 이름 정보 (옵셔널)
    var total_count: Int?      // 총 개수 (옵셔널)
}

// 동일 이름 지역 정보 모델
struct SameName: Codable {
    var keyword: String?       // 키워드 (옵셔널)
    var region: [String]?      // 지역 (옵셔널)
    var selected_region: String?  // 선택된 지역 (옵셔널)
}

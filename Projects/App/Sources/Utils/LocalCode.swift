//
//  LocalCode.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import Foundation

public enum LocalCode: Int, CaseIterable {
    case Seoul, Daegu, Busan, Daejeon, Gyeonggi, Incheon, Gwangju, Ulsan, Gangwon, Chungbuk, Chungnam, Jeonbuk, Jeonnam, Gyeongbuk, Gyeongnam, Jeju, Changwon
    
    var name: String {
        switch self {
        case .Daegu: return "대구광역시"
        case .Busan: return "부산광역시"
        case .Incheon: return "인천광역시"
        case .Seoul: return "서울특별시"
        case .Gwangju: return "광주광역시"
        case .Daejeon: return "대전광역시"
        case .Ulsan: return "울산광역시"
        case .Gyeonggi: return "경기도"
        case .Gangwon: return "강원특별자치도"
        case .Chungbuk: return "충청북도"
        case .Chungnam: return "충청남도"
        case .Jeonbuk: return "전북특별자치도"
        case .Jeonnam: return "전라남도"
        case .Gyeongbuk: return "경상북도"
        case .Gyeongnam: return "경상남도"
        case .Jeju: return "제주특별자치도"
        case .Changwon: return "창원시"
        }
    }
    
    var country: [String: String] {
        switch self {
        case .Seoul: return ["강남구": "101010", "강동구": "101020", "강북구": "101030", "강서구": "101040", "관악구": "101050", "광진구": "101060", "구로구": "101070", "금천구": "101080", "노원구": "101090", "도봉구": "101100", "동대문구": "101110", "동작구": "101120", "마포구": "101130", "서대문구": "101140", "서초구": "101150", "성동구": "101160", "성북구": "101170", "송파구": "101180", "양천구": "101190", "영등포구": "101200", "용산구": "101210", "은평구": "101220", "종로구": "101230", "중구": "101240", "중랑구": "101250"]
        case .Gyeonggi: return ["가평군": "102010", "고양시": "102020", "과천시": "102060", "광명시": "102070", "광주시": "102080", "구리시": "102090", "군포시": "102100", "김포시": "102110", "남양주시": "102120", "동두천시": "102130", "부천시": "102140", "성남시": "102180","수원시": "102220", "시흥시": "102270", "안산시": "102280", "안성시": "102310", "안양시": "102320", "양주시": "102350", "여주시": "102370", "오산시": "102390", "용인시": "102400", "의왕시": "102440", "의정부시": "102450", "이천시": "102460", "파주시": "102470", "평택시": "102480", "포천시": "102490", "하남시": "102500", "화성시": "102510"]
        case .Gwangju: return ["광산구": "103010", "남구": "103020", "동구": "103030", "북구": "103040", "서구": "103050"]
        case .Daegu: return ["남구": "104010", "달서구": "104020", "달성군": "104030", "동구": "104040", "북구": "104050", "서구": "104060", "수성구": "104070", "중구": "104080", "군위군": "104090"]
        case .Daejeon: return ["대덕구": "105010", "동구": "105020", "서구": "105030", "유성구": "105040", "중구": "105050"]
        case .Busan: return ["강서구": "106010", "금정구": "106020", "기장군": "106030", "남구": "106040", "동구": "106050", "동래구": "106060", "부산진구": "106070", "북구": "106080", "사상구": "106090", "사하구": "106100", "서구": "106110", "수영구": "106120", "연제구": "106130", "영도구": "106140", "중구": "106150", "해운대구": "106160"]
        case .Ulsan: return ["남구": "107010", "동구": "107020", "북구": "107030", "울주군": "107040", "중구": "107050"]
        case .Incheon: return ["강화군": "108010", "계양구": "108020", "미추홀구": "108030", "남동구": "108040", "동구": "108050", "부평구": "108060", "서구": "108070", "연수구": "108080", "옹진군": "108090", "중구": "108100"]
        case .Gangwon: return ["강릉시": "109010", "고성군": "109020", "동해시": "109030", "삼척시": "109040", "속초시": "109050", "양구군": "109060", "양양군": "109070", "영월군": "109080", "원주시": "109090", "인제군": "109100", "정선군": "109110", "철원군": "109120", "춘천시": "109130", "태백시": "109140", "평창군": "109150", "홍천군": "109160", "화천군": "109170", "횡성군": "109180"]
        case .Gyeongnam: return ["거제시": "110010", "거창군": "110020", "고성군": "110030", "김해시": "110040", "남해군": "110050", "밀양시": "110070", "사천시": "110080", "산청군": "110090", "양산시": "110100", "의령군": "110110", "진주시": "110120", "창녕군": "110150", "통영시": "110160", "하동군": "110170", "함안군": "110180", "함양군": "110190", "합천군": "110200"]
        case .Changwon: return ["마산회원구": "110053", "마산합포구": "110055", "성산구": "110057", "의창구": "110059", "진해시": "110130"]
        case .Gyeongbuk: return ["경산시": "111010", "경주시": "111020", "고령시": "111030", "구미시": "111040", "군위군": "111050", "김천시": "111060", "문경시": "111070", "봉화군": "111080", "상주시": "111090", "성주군": "111100", "안동시": "111110", "영덕군": "111120", "영양군": "111130", "영주시": "111140", "영천시": "111150", "예천군": "111160", "울릉군": "111170", "울진군": "111180", "의성군": "111190", "청도군": "111200", "청송군": "111210", "칠곡군": "111220", "포항 남구": "111240", "포항 북구": "111250"]
        case .Jeonnam: return ["강진군": "112010", "고흥군": "112020", "곡성군": "112030", "광양시": "112040", "구례군": "112050", "나주시": "112060", "담양군": "112070", "목포시": "112080", "무안군": "112090", "보성군": "112100", "순천시": "112110", "신안군": "112120", "여수시": "112130", "영광군": "112140", "영암군": "112150", "완도군": "112160", "장성군": "112170", "장흥군": "112180", "진도군": "112190", "함평군": "112200", "해남군": "112210", "화순군": "112210"]
        case .Jeonbuk: return ["고창군": "113010", "군산시": "113020", "김제시": "113030", "남원시": "113040", "무주군": "113050", "부안군": "113060", "순창군": "113070", "완주군": "113080", "익산시": "113090", "임실군": "113100", "장수군": "113110", "전주시": "113120", "정읍군": "113150", "진안군": "113160"]
        case .Chungbuk: return ["괴산군": "114010", "단양군": "114020", "보은군": "114030", "영동군": "114040", "옥천군": "114050", "음성군": "114060", "제천시": "114070", "증평군": "114080", "진천군": "114090", "청원군": "114100", "청주시": "114110", "충주시": "114140"]
        case .Chungnam: return ["계룡시": "115010", "공주시": "115020", "금산군": "115030", "논산시": "115040", "당진시": "115050", "보령시": "115060", "부여군": "115070", "서산시": "115080", "서천군": "115090", "아산시": "115100", "연기군": "115110", "예산군": "115120", "천안시": "115130", "청양군": "115140", "태안군": "115150", "홍성군": "115160"]
        case .Jeju: return ["서귀포시": "116030", "제주시": "116040"]
        }
    }
}


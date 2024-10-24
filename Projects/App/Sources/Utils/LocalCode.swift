//
//  LocalCode.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import Foundation

public enum LocalCode: Int, CaseIterable {
    case Daegu = 1040
    case Seoul = 1010
    case Busan = 1060
    case Incheon = 1, Gwangju, Daejeon, Ulsan, Gyeonggi, Gangwon, Chungbuk, Chungnam, Jeonbuk, Jeonnam, Gyeongbuk, Gyeongnam, Jeju
    
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
        }
    }
    
    var country: [String] {
        switch self {
        case .Daegu: return ["남구", "달서구", "달성군", "동구", "북구", "서구", "수성구", "중구", "군위군"]
        case .Busan: return ["강서구", "금정구", "기장군", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구"]
        case .Incheon: return ["중구", "동구", "미추홀구", "연수구", "남동구", "부평구", "계양구", "서구", "강화군", "옹진군"]
        case .Seoul: return ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
        case .Gwangju: return ["동구", "서구", "남구", "북구", "광산구"]
        case .Daejeon: return ["동구", "중구", "서구", "유성구", "대덕구"]
        case .Ulsan: return ["울주군", "중구", "북구", "동구", "남구"]
        case .Gyeonggi: return ["수원시", "성남시", "용인시", "안산시", "안양시", "과천시", "광명시", "광주시", "군포시", "부천시", "시흥시", "김포시","안성시", "오산시", "의왕시", "이천시", "평택시", "하남시", "화성시", "여주시", "고양시", "구리시", "남양주시", "동두천시", "양주시", "의정부시", "포천시", "파주시"]
        case .Gangwon: return ["원주시", "춘천시", "강릉시", "동해시", "속초시", "삼척시", "태백시", "흥천군", "철원군", "횡성군", "평창군", "정선군", "영월군", "인제군", "고성군", "양양군", "화천군", "양구군"]
        case .Chungbuk: return ["청주시", "충주시", "제천시", "보은군", "옥천군", "영동군", "증평군", "진천군", "괴산군", "음성군", "단양군"]
        case .Chungnam: return ["천안시", "공주시", "보령시", "아산시", "서산시", "논산시", "계룡시", "당진시", "금산군", "부여군", "서천군", "청양군", "홍성군", "예산군", "태안군"]
        case .Jeonbuk: return ["전주시", "익산시", "군산시", "정읍시", "김제시", "남원시", "완주군", "고창군", "부안군", "임실군", "순창군", "진안군", "무주군", "장수군"]
        case .Jeonnam: return ["목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", "함평군", "영광군", "장성군", "완도군", "진도군", "신안군"]
        case .Gyeongbuk: return ["포항시", "경주시", "김천시", "안동시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시", "의성군", "청송군", "영양군", "영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군", "울진군", "울릉군"]
        case .Gyeongnam: return ["창원시", "김해시", "진주시", "양산시", "거제시", "통영시", "사천시", "밀양시", "함안군", "거창군", "창녕군", "고성군", "하동군", "합천군", "남해군", "함양군", "산청군", "의령군"]
        case .Jeju: return ["제주시", "서귀포시"]
        }
    }
}


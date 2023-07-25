//
//  LocationModel.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/25.
//

import Foundation

struct LocationResponse: Codable {
    let pageRange: [Int]
    let total: Int
    let row: [LocationData]
}

struct LocationData: Codable {
    let areaNm: String
    let congestionColor: String
    let areaCongestLvl: String
    let areaCongestNum: Int
    let category: String
    let x, y: String

    enum CodingKeys: String, CodingKey {
        case areaNm = "area_nm"
        case congestionColor = "congestion_color"
        case areaCongestLvl = "area_congest_lvl"
        case areaCongestNum = "area_congest_num"
        case category, x, y
    }
}

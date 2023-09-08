//
//  DetailLocationResponse.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/09/08.
//

import Foundation

struct DetailLocationData: Codable {
    let malePpltnRate, onehourRateUpDown, congestionColor, hotspotNm: String
    let genderMax, congestionInstruction, threehourRateUpDown, maxResidentText: String
    let nonResidentValue, rate40, rate60, rate20: String
    let onehourRate, residentValue, congestionText, genderMaxLvl: String
    let rate40_Value, femalePpltnRate, rate30_Value, rate50_Value: String
    let onemonthRateUpDown, rate20_Value, rate60_Value, onemonthRate: String
    let minResidentText, totalMax, threehourRate, rate50: String
    let residentDiff, genderMinLvl, rate10, congestionLabelValue: String
    let cellPlaceText, rate30, rate10_Value, totalMaxLvl: String

    enum CodingKeys: String, CodingKey {
        case malePpltnRate = "MALE_PPLTN_RATE"
        case onehourRateUpDown = "ONEHOUR_RATE_UP_DOWN"
        case congestionColor = "congestion_color"
        case hotspotNm = "hotspot_nm"
        case genderMax = "GENDER_MAX"
        case congestionInstruction = "congestion_instruction"
        case threehourRateUpDown = "THREEHOUR_RATE_UP_DOWN"
        case maxResidentText = "MAX_RESIDENT_TEXT"
        case nonResidentValue = "NON_RESIDENT_VALUE"
        case rate40 = "RATE_40"
        case rate60 = "RATE_60"
        case rate20 = "RATE_20"
        case onehourRate = "ONEHOUR_RATE"
        case residentValue = "RESIDENT_VALUE"
        case congestionText = "congestion_text"
        case genderMaxLvl = "GENDER_MAX_LVL"
        case rate40_Value = "RATE_40_VALUE"
        case femalePpltnRate = "FEMALE_PPLTN_RATE"
        case rate30_Value = "RATE_30_VALUE"
        case rate50_Value = "RATE_50_VALUE"
        case onemonthRateUpDown = "ONEMONTH_RATE_UP_DOWN"
        case rate20_Value = "RATE_20_VALUE"
        case rate60_Value = "RATE_60_VALUE"
        case onemonthRate = "ONEMONTH_RATE"
        case minResidentText = "MIN_RESIDENT_TEXT"
        case totalMax = "TOTAL_MAX"
        case threehourRate = "THREEHOUR_RATE"
        case rate50 = "RATE_50"
        case residentDiff = "RESIDENT_DIFF"
        case genderMinLvl = "GENDER_MIN_LVL"
        case rate10 = "RATE_10"
        case congestionLabelValue = "congestion_label_value"
        case cellPlaceText = "cell_place_text"
        case rate30 = "RATE_30"
        case rate10_Value = "RATE_10_VALUE"
        case totalMaxLvl = "TOTAL_MAX_LVL"
    }
}

typealias DetailLocationResponse = [DetailLocationData]

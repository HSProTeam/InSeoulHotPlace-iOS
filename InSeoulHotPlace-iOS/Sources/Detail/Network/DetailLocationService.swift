//
//  DetailLocationService.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/09/08.
//

import Foundation
import Moya

enum DetailLocationService {
    case getDetailLocationData(locationName: String)
}

extension DetailLocationService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstant.detailURL)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getDetailLocationData(let locationName):
            let param: [String : Any] = [
                "hotspotNm" : locationName
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

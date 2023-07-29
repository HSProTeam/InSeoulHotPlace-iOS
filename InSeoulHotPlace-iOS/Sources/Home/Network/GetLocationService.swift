//
//  LocationService.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/25.
//

import Foundation
import Moya

enum GetLocationService {
    case getLocationService
}

extension GetLocationService: TargetType {
    var baseURL: URL {
        return URL(string: APIConstant.baseURL)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        let param: [String : Any] = [
            "page" : 1,
            "category" : "전체보기",
            "count" : 113,
            "sort" : true
        ]
        return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

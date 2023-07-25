//
//  LocationService.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/25.
//

import Foundation
import Moya

enum GetLocationService {
    case getLocationService(Void)
//    case getLocationService(page: Int, category: String, count: Int, sort: Bool)
}

extension GetLocationService {
    var baseURL: URL {
        return URL(string: APIConstant.baseURL)!
    }
    
    var path: String {
        return APIConstant.getCategory
    }
    
    var methoe: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var header: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

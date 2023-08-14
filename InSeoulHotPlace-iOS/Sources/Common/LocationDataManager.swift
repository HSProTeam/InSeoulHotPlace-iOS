//
//  LocationDataManager.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/30.
//

import Foundation

class LocationDataManager {
    static func saveLocationData(
        locations: [String]
    ) {
        do {
            let jsonData = try JSONEncoder().encode(locations)
            let jsonString = String(data: jsonData, encoding: .utf8)
            UserDefaults.standard.set(jsonString, forKey: "saveLocationData")
            print("DEBUG: LocationDataManager → saveLocationData(데이터 저장에 성공하였습니다.) \n\(locations)")
        }
        catch {
            print("DEBUG: LocationDataManager → saveLocationData(데이터 저장에 실패하였습니다.)")
        }
    }
    
    static func fetchLocationData() -> [String]? {
        if let jsonString = UserDefaults.standard.string(forKey: "saveLocationData"),
           let jsonData = jsonString.data(using: .utf8)
        {
            do {
                let locations = try JSONDecoder().decode([String].self, from: jsonData)
                print("DEBUG: LocationDataManager → fetchLocationData(데이터를 읽어오는데 성공하였습니다.) \n\(locations)")
                return locations
            }
            catch {
                print("DEBUG: LocationDataManager → fetchLocationData(데이터를 읽어오는데 실패하였습니다.)")
            }
        }
        return nil
    }
}

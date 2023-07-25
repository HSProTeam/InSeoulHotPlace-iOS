//
//  LocationTableViewHeaderView.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/25.
//

import UIKit

final class LocationTableViewHeaderView: UITableViewHeaderFooterView {
    
    private let searchTextField = UITextField().then {
        $0.placeholder = "원하는 장소를 입력해주세요"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }
}


// MARK: - Setup helper
private extension LocationTableViewHeaderView {
    func setupViews() {
        
    }
    
    func setupLayouts() {
        
    }
}

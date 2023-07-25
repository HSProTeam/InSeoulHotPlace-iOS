//
//  locationTableViewCell.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/25.
//

import UIKit

final class LocationTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel().then {
        $0.text = "Test cell"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Setup helper
private extension LocationTableViewCell {
    func setupViews() {
        contentView.addSubview(titleLabel)
    }
    
    func setupLayouts() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(16)
        }
    }
}


// MARK: Binding helper
extension LocationTableViewCell {
    func setupBindingCell(
        title: String
    ) {
        titleLabel.text = title
    }
}

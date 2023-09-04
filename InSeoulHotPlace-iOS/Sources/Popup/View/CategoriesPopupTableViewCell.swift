//
//  CategoriesPopupTableViewCell.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/09/04.
//

import UIKit

final class CategoriesPopupTableViewCell: UITableViewCell {
    
    private let categoryLabel = UILabel().then {
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
private extension CategoriesPopupTableViewCell {
    func setupViews() {
        contentView.addSubview(categoryLabel)
    }
    
    func setupLayouts() {
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }
    }
}


// MARK: - for Controller
extension CategoriesPopupTableViewCell {
    func setupCell(
        category: String
    ) {
        categoryLabel.text = category
    }
}

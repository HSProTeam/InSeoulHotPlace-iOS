//
//  locationTableViewCell.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/25.
//

import UIKit
import RxSwift

protocol LocationTableViewCellDelegate: AnyObject {
    func favoriteButtonDidTap(locationName: String, isSelected: Bool)
}

final class LocationTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .black
    }
    
    private let favoriteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.setImage(UIImage(systemName: "star.fill"), for: .selected)
    }
    
    private lazy var disposeBag = DisposeBag()
    weak var delegate: LocationTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayouts()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Setup helper
private extension LocationTableViewCell {
    func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
    }
    
    func setupLayouts() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(16)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupBinding() {
        favoriteButton.rx.tap
            .asSignal()
            .withUnretained(self)
            .emit(with: self, onNext: { owner, _ in
                owner.favoriteButton.isSelected.toggle()
                owner.favoriteButton.tintColor = owner.favoriteButton.isSelected ? .systemYellow : .darkGray
                owner.delegate?.favoriteButtonDidTap(
                    locationName: owner.titleLabel.text ?? "",
                    isSelected: owner.favoriteButton.isSelected
                )
            })
            .disposed(by: disposeBag)
    }
}


// MARK: Binding helper
extension LocationTableViewCell {
    func setupBindingCell(
        locationName: String,
        isExis: Bool
//        congestColor: String
    ) {
        titleLabel.text = locationName
        favoriteButton.isSelected = isExis
        favoriteButton.tintColor = isExis ? .systemYellow : .darkGray
        
//        contentView.setGradient(color1: .white, color2: UIColor(hexCode: congestColor))
//        contentView.bringSubviewToFront(titleLabel)
//        contentView.bringSubviewToFront(favoriteButton)
    }
}

//
//  FilterCollectionViewCell.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/08/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol FilterCollectionViewDelegate: AnyObject {
    func filterDidTap(filterType: FilterType, isActive: Bool)
}

final class FilterCollectionViewCell: UICollectionViewCell {
    private let filterButton = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        
        $0.layer.cornerRadius = 16.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    private lazy var disposeBag = DisposeBag()
    private var cellFilterType: FilterType?
    weak var delegate: FilterCollectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayouts()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup helper
private extension FilterCollectionViewCell {
    func setupViews() {
        contentView.addSubview(filterButton)
    }
    
    func setupLayouts() {
        filterButton.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview().inset(2)
        }
    }
    
    func setupBinding() {
        filterButton.rx.tap
            .withUnretained(self)
            .subscribe(with: self, onNext: { owner, _ in
                owner.filterButton.isSelected.toggle()
                owner.filterButton.backgroundColor = owner.filterButton.isSelected ? .black : .white
                
                guard let type = owner.cellFilterType else { return }
                owner.delegate?.filterDidTap(filterType: type, isActive: owner.filterButton.isSelected)
            })
            .disposed(by: disposeBag)
    }
}


// MARK: - for Cell
extension FilterCollectionViewCell {
    func setupCell(
        cellType: FilterType,
        cellTitle: String
    ) {
        cellFilterType = cellType
        filterButton.setTitle(cellTitle, for: .normal)
    }
}

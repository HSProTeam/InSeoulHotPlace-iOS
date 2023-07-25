//
//  SearchTextFieldView.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/25.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchTextFieldDelegate: AnyObject {
    func searchText(title: String)
}

final class SearchTextFieldView: UIView {
    
    private let searchTextField = UITextField().then {
        $0.placeholder = "원하는 장소를 입력해주세요"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    }
    
    private lazy var disposeBag = DisposeBag()
    weak var delegate: SearchTextFieldDelegate?
    
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
private extension SearchTextFieldView {
    func setupViews() {
        backgroundColor = .white
        
        addSubview(searchTextField)
    }
    
    func setupLayouts() {
        searchTextField.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview().inset(8)
        }
    }
    
    func setupBinding() {
        searchTextField.rx.text.orEmpty
            .asDriver()
            .drive(onNext: { [weak self] text in
                self?.delegate?.searchText(title: text)
            })
            .disposed(by: disposeBag)
    }
}

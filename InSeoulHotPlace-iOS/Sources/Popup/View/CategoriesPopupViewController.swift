//
//  CategoriesPopupViewController.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/09/04.
//

import UIKit
import RxSwift
import RxCocoa

final class CategoriesPopupViewController: BaseViewController {
    private let backgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    }
    private let backgroundViewTapGesture = UITapGestureRecognizer(
        target: CategoriesPopupViewController.self,
        action: nil
    ).then {
        $0.cancelsTouchesInView = false
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24
    }
    
    private let headerLabel = UILabel().then {
        $0.text = "카테고리"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    
    private let divisionView = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    private let categoriesTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        
        $0.register(
            CategoriesPopupTableViewCell.self,
            forCellReuseIdentifier: "CategoriesPopupTableViewCell"
        )
    }
    
    private let resetButton = UIButton().then {
        $0.setTitle("초기화", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .systemGray2
        $0.layer.cornerRadius = 10
    }
    
    private let applyButton = UIButton().then {
        $0.setTitle("적용", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 10
    }
    
    private lazy var disposeBag = DisposeBag()
    private let viewModel: CategoriesPopupViewModel?
    
    init(
        viewModel: CategoriesPopupViewModel
    ) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        view.addSubview(backgroundView)
        view.addSubview(contentView)
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(divisionView)
        contentView.addSubview(categoriesTableView)
        contentView.addSubview(resetButton)
        contentView.addSubview(applyButton)
    }
    
    override func setupLayouts() {
        backgroundView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(16)
        }
        
        divisionView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        categoriesTableView.snp.makeConstraints {
            $0.top.equalTo(divisionView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        resetButton.snp.makeConstraints {
            $0.top.equalTo(categoriesTableView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
            $0.width.equalTo(72)
            $0.height.equalTo(48)
        }
        
        applyButton.snp.makeConstraints {
            $0.leading.equalTo(resetButton.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(48)
        }
    }
    
    override func setupBinding() {
        viewModel?.categoriesDriver
            .drive(categoriesTableView.rx.items(
                cellIdentifier: "CategoriesPopupTableViewCell",
                cellType: CategoriesPopupTableViewCell.self)
            ) { row, items, cell in
                print("DEBUG: viewModel talbeView Cell \(row) ~ \(items)")
                cell.selectionStyle = .none
                cell.setupCell(category: items)
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        applyButton.rx.tap
            .asDriver()
            .drive(with: self, onNext: { owner, _ in
                owner.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        
        backgroundViewTapGesture.rx.event
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.dismiss(animated: false)
            })
            .disposed(by: disposeBag)
        backgroundView.addGestureRecognizer(backgroundViewTapGesture)
    }
}

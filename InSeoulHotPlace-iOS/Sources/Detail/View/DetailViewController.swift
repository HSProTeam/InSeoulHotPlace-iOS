//
//  DetailViewController.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/08/30.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: BaseViewController {
    
    private let congestView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 15
    }
    
    private let congestLabelView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
    }
    private let congestLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let ageRateView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let genderRateView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let instructionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    
    private lazy var disposeBag = DisposeBag()
    private var detailLocationData: LocationData?
    private var viewModel: DetailLocationViewModel?
    
    init(
        detailLocationData: LocationData,
        viewModel: DetailLocationViewModel
    ) {
        super.init()
        self.detailLocationData = detailLocationData
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = detailLocationData?.areaNm
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupViews() {
        view.backgroundColor = .white
        view.addSubview(congestView)
        
        congestView.addSubview(congestLabelView)
        congestLabelView.addSubview(congestLabel)
        congestLabelView.addSubview(instructionLabel)
        
        congestView.addSubview(instructionLabel)
    }
    
    override func setupLayouts() {
        congestView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        congestLabelView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        congestLabel.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview().inset(8)
        }
        
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(congestLabelView.snp.bottom).offset(12)
            $0.leading.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func setupBinding() {
        
    }
}

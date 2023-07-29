//
//  HomeViewController.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/23.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    
    private let searchTextFieldView = SearchTextFieldView()
    private let locationTableView = UITableView().then {
        $0.separatorStyle = .none
        
        $0.register(
            LocationTableViewCell.self,
            forCellReuseIdentifier: "LocationTableViewCell"
        )
    }
    
    private lazy var disposeBag = DisposeBag()
    private let viewModel = LocationViewModel()
    private var locationData: [LocationData]?
    
    override func setupViews() {
        view.backgroundColor = .white
        view.addSubview(searchTextFieldView)
        view.addSubview(locationTableView)
        
        searchTextFieldView.delegate = self
    }
    
    override func setupLayouts() {
        searchTextFieldView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        locationTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextFieldView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBinding() {
        viewModel.fetchLocationRequest()
        
        viewModel.loacationSubject
            .bind(to: locationTableView.rx.items(
                cellIdentifier: "LocationTableViewCell",
                cellType: LocationTableViewCell.self)
            ) { row, item, cell in
                cell.selectionStyle = .none
                cell.setupBindingCell(title: item.areaNm)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - SearchTextFieldView Delegate
extension HomeViewController: SearchTextFieldDelegate {
    func searchText(title: String) {
        print("DEBUG: title is \(title)")
    }
}

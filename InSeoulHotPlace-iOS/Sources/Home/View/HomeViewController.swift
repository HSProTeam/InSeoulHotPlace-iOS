//
//  HomeViewController.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/23.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private let searchTextFieldView = SearchTextFieldView()
    private let locationTableView = UITableView().then {
        $0.backgroundColor = .systemGreen
    }
    
    override func setupViews() {
        view.backgroundColor = .white
        view.addSubview(searchTextFieldView)
        view.addSubview(locationTableView)
        
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
        
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
        
    }
}

// MARK: - SearchTextFieldView Delegate
extension HomeViewController: SearchTextFieldDelegate {
    func searchText(title: String) {
        print("DEBUG: title is \(title)")
    }
}


// MARK: - UITableView Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "LocationTableViewCell",
            for: indexPath
        ) as? LocationTableViewCell
        else { return UITableViewCell() }
        
        cell.setupBindingCell(title: "This cell is test")
        
        return cell
    }
}

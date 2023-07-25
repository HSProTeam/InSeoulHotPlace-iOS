//
//  HomeViewController.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/23.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private let locationTableView = UITableView().then {
        $0.backgroundColor = .systemGreen
    }
    
    override func setupViews() {
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
        
        view.addSubview(locationTableView)
    }
    
    override func setupLayouts() {
        locationTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupBinding() {
        
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

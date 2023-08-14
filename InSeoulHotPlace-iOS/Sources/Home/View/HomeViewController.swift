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
    
    private let searchTextField = UITextField().then {
        $0.placeholder = "  원하는 장소를 입력해주세요"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.tintColor = .black
        
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        
        $0.addLeftImageView(image: UIImage(systemName: "magnifyingglass")!)
    }
    
    private let locationTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        
        $0.register(
            LocationTableViewCell.self,
            forCellReuseIdentifier: "LocationTableViewCell"
        )
    }
    
    private lazy var disposeBag = DisposeBag()
    private let viewModel = LocationViewModel()
    private var savedFavoriteLocationData = BehaviorRelay<[String]>(value: Array.init())
    
    override func setupViews() {
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(locationTableView)
    }
    
    override func setupLayouts() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        locationTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func setupBinding() {
        savedFavoriteLocationData.accept(LocationDataManager.fetchLocationData() ?? [])
        
        viewModel.fetchLocationRequest()
        viewModel.sortByFavorite(locations: savedFavoriteLocationData.value)
        viewModel.locationDriver
            .drive(locationTableView.rx.items(
                cellIdentifier: "LocationTableViewCell",
                cellType: LocationTableViewCell.self)
            ) { [weak self] row, items, cell in
                let locationName: String = items.areaNm
                
                cell.delegate = self
                cell.selectionStyle = .none
                cell.setupBindingCell(
                    locationName: locationName,
                    isExis: self?.savedFavoriteLocationData.value.contains(locationName) ?? false
                )
            }
            .disposed(by: disposeBag)
    }
}


// MARK: - LocationTableViewCell Delegate
extension HomeViewController: LocationTableViewCellDelegate {
    func favoriteButtonDidTap(
        locationName: String,
        isSelected: Bool
    ) {
        var oldFavoritedLocations: [String] = LocationDataManager.fetchLocationData() ?? []
        isSelected ? oldFavoritedLocations.append(locationName) : oldFavoritedLocations.removeAll { $0 == locationName }
        savedFavoriteLocationData.accept(oldFavoritedLocations)
        LocationDataManager.saveLocationData(locations: oldFavoritedLocations)
        
        viewModel.sortByName()
        viewModel.sortByFavorite(locations: oldFavoritedLocations)
    }
}

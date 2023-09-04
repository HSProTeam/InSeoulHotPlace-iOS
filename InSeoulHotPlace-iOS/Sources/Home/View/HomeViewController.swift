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
    
    private let filterLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = CGFloat(4)
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 76, height: 40)
    }
    
    private lazy var filterCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: filterLayout
    ).then {
        $0.backgroundColor = .white
        $0.register(
            FilterCollectionViewCell.self,
            forCellWithReuseIdentifier: "FilterCollectionViewCell"
        )
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
    private let filterTypeArray: [FilterType] = [.Reset, .Name, .CongestLevel, .Categories]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func setupViews() {
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .white
        view.addSubview(searchTextField)
        view.addSubview(filterCollectionView)
        view.addSubview(locationTableView)
    }
    
    override func setupLayouts() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        filterCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(48)
        }
        
        locationTableView.snp.makeConstraints {
            $0.top.equalTo(filterCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func setupBinding() {
        savedFavoriteLocationData.accept(LocationDataManager.fetchLocationData() ?? [])
        
        /// for Collection View
        viewModel.filterDriver
            .drive(filterCollectionView.rx.items(
                cellIdentifier: "FilterCollectionViewCell",
                cellType: FilterCollectionViewCell.self)
            ) { [weak self] row, items, cell in
                guard let self = self else { return }
                cell.delegate = self
                cell.setupCell(
                    filterType: self.filterTypeArray[row],
                    filterName: items
                )
            }
            .disposed(by: disposeBag)
        
        /// for Table View
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
        
        locationTableView.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak self] index in
                guard let self = self else { return }
                let data = self.viewModel.locationRelay.value[index.row]
                
                let controller = DetailViewController(data: data)
                self.navigationController?.pushViewController(controller, animated: true)
            })
            .disposed(by: disposeBag)
    }
}


// MARK: - for Delegate
extension HomeViewController:
    LocationTableViewCellDelegate,
    FilterCollectionViewDelegate
{
    /// FilterCollectionViewCell Delegate
    func filterDidTap(filterType: FilterType, isActive: Bool) {
        print("DEBUG: Cell did tap →\(filterType), \(isActive)")
        guard isActive else { return }
        
        switch filterType {
        case  .Reset,
              .Name:
            viewModel.sortByName()
            
        case .CongestLevel:
            viewModel.sortByCongestLevel()
            
        case .Categories:
            print("DEBUG: 카테고리 팝업창이 띄어집니다.")
        }
        
        viewModel.sortByFavorite(locations: savedFavoriteLocationData.value)
    }
    
    /// LocationTableViewCell Delegate
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
        
        locationTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}

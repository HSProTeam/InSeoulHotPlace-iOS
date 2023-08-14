//
//  LocationViewModel.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/25.
//

import Moya
import RxMoya
import RxSwift
import RxCocoa

final class LocationViewModel {
    private lazy var disposeBag = DisposeBag()
    private let provider = MoyaProvider<GetLocationService>()
    private let locationRelay = BehaviorRelay<[LocationData]>(value: Array.init())
    private var favoriteLocations: [String] = LocationDataManager.fetchLocationData() ?? []
    
    var locationDriver: Driver<[LocationData]> {
        return locationRelay.asDriver()
    }
    
    func fetchLocationRequest() {
        provider.rx.request(.getLocationService)
            .subscribe { [weak self] result in
                switch result {
                case .success(let response):
                    print("DEBUG: fetchLocationRequest is successed")
                    guard let responseData = try? response.map(LocationResponse.self) else { return }
                    self?.updateLocation(newData: responseData.row)
                    self?.sortByFavorite(locations: self?.favoriteLocations ?? [])
                    
                case .failure(let error):
                    print("DEBUG: fetchLocationRequest error is \(error.localizedDescription)")
                }
            }
            .disposed(by: disposeBag)
    }
    
    /// Update locationRelay
    private func updateLocation(newData: [LocationData]) {
        locationRelay.accept(newData)
    }
}


// MARK: - Sort helper
extension LocationViewModel {
    /// Sort by Favorite location
    func sortByFavorite(
        locations: [String]
    ) {
        let data = locationRelay.value
        let favoriteLocations: [LocationData] = data.filter {
            locations.contains($0.areaNm)
        }
        let nonFavoriteLocations: [LocationData] = data.filter {
            !locations.contains($0.areaNm)
        }
        updateLocation(newData: favoriteLocations + nonFavoriteLocations)
    }
    
    /// Sort by Name
    func sortByName() {
        let sortedLocation = locationRelay.value.sorted { first, second in
            return first.areaNm < second.areaNm
        }
        updateLocation(newData: sortedLocation)
    }
    
    /// Sort by Congest level
    func sortByCongestLevel() {
        let sortedLocation = locationRelay.value.sorted { first, second in
            return first.areaCongestLvl > second.areaCongestLvl
        }
        updateLocation(newData: sortedLocation)
    }
}

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
    var loacationSubject = BehaviorSubject<[LocationData]>(value: Array.init())
    
    func fetchLocationRequest() {
        provider.rx.request(.getLocationService)
            .subscribe { [weak self] result in
                switch result {
                case .success(let response):
                    guard let responseData = try? response.map(LocationResponse.self) else { return }
                    self?.loacationSubject.onNext(responseData.row)
                    
                case .failure(let error):
                    print("DEBUG: fetchLocationRequest error is \(error.localizedDescription)")
                }
            }
            .disposed(by: disposeBag)
    }
}

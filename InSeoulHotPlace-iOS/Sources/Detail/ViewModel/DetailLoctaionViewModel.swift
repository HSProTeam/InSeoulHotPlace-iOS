//
//  DetailLoctaionViewModel.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/09/08.
//

import RxSwift
import RxCocoa
import Moya
import RxMoya

final class DetailLocationViewModel {
    private lazy var disposeBag = DisposeBag()
    private let provider = MoyaProvider<DetailLocationService>()
    
    init(locationName: String) {
        fetchDetailLocationData(locationName: locationName)
    }
    
    func fetchDetailLocationData(
        locationName: String
    ) {
        provider.rx.request(.getDetailLocationData(locationName: locationName))
            .subscribe { result in
                switch result {
                case .success(let response):
                    print("DEBUG: fetchDetailLocationRequest is successed")
                    guard let responseData = try? response.map(DetailLocationResponse.self) else { return }
                    print("DEBUG: Detail data is \(responseData)")
                    
                    
                case .failure(let error):
                    print("DEBUG: fetchDetailLocationRequest error is \(error.localizedDescription)")
                }
            }
            .disposed(by: disposeBag)
    }
}

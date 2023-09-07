//
//  CategoriesPopupViewModel.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/09/04.
//

import RxSwift
import RxCocoa

final class CategoriesPopupViewModel {
    private lazy var diseposeBag = DisposeBag()
    private let categoriesRelay = BehaviorRelay<[String]>(value: Array.init())
    var categoriesDriver: Driver<[String]> {
        return categoriesRelay.asDriver()
    }
    
    init(
        categories: [String]
    ) {
        categoriesRelay.accept(categories)
    }
}

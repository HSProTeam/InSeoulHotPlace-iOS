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
    
    init(data: LocationData) {
        super.init()
        
        print("DEBUG: detail data is \(data)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "자세히 보기"
        navigationController?.navigationBar.tintColor = .black
        
    }
    
    override func setupViews() {
        view.backgroundColor = .white
    }
    
    override func setupLayouts() {
        
    }
    
    override func setupBinding() {
        
    }
}

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
    
    private var detailLocationData: LocationData?
    private var viewModel: DetailLocationViewModel?
    
    init(
        detailLocationData: LocationData,
        viewModel: DetailLocationViewModel
    ) {
        super.init()
        self.detailLocationData = detailLocationData
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = detailLocationData?.areaNm
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

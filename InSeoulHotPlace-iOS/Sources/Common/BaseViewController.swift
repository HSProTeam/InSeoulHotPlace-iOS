//
//  BaseViewController.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/23.
//

import UIKit
import SnapKit
import Then

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayouts()
        setupBinding()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(corder: NSCoder)")
    }
    
    func setupViews() {}
    func setupLayouts() {}
    func setupBinding() {}
}

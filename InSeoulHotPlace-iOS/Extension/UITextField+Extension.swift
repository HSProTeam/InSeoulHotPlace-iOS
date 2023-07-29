//
//  UITextField+Extension.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/07/29.
//

import UIKit

extension UITextField {
    func addLeftPadding(
        padding: CGFloat
    ) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addLeftImageView(
        image: UIImage
    ) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        imageView.image = image
        self.leftView = imageView
        self.leftViewMode = .always
    }
}

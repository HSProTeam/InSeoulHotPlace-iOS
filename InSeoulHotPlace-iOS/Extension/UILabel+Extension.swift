//
//  UILabel+Extension.swift
//  InSeoulHotPlace-iOS
//
//  Created by 이지석 on 2023/09/11.
//

import UIKit

extension UILabel {
    func changeSomeText(
        text: String,
        target: String,
        fontSize: CGFloat,
        fontWeight: UIFont.Weight,
        fontColor: UIColor? = nil
    ) {
        let font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.font, value: font, range: (text as NSString).range(of: target))
        
        if let fontColor = fontColor {
            attributedString.addAttribute(.foregroundColor, value: fontColor, range: (text as NSString).range(of: target))
        }
        
        self.attributedText = attributedString
    }
    
    func changeSomeHTMLtoString(
        htmlText: String
    ) {
        if let data = htmlText.data(using: .utf8) {
            if let attributedString = try? NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            ) {
                self.attributedText = attributedString
            }
        }
    }
}

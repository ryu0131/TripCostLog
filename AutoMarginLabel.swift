//
//  AutoMarginLabel.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2021/02/20.
//

import UIKit
//ラベル余白を固定
class AutoMarginLabel: UILabel {
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 5, right: 5)
    
    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }
}

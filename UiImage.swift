//
//  UiImage.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2021/01/10.
//
import Foundation
import UIKit

extension UIImage {
    func resize(_ width: CGFloat) -> UIImage? {
        
        let resizedSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }
}

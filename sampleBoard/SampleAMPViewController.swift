//
//  SampleAMPViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/12/27.
//

import UIKit
import AMJpnMap

class SampleAMPViewController: UIViewController {
    
    @IBOutlet weak var detailView: AMJpnMapDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailView.strokeColor = .clear
        AMPrefecture.allCases.forEach {
            detailView.setFillColor(color: randomColor(alpha: 1.0), prefecture: $0)
        }
    }
    
    private func randomColor(alpha: CGFloat) -> UIColor {
        let r = CGFloat.random(in: 0...255) / 255.0
        let g = CGFloat.random(in: 0...255) / 255.0
        let b = CGFloat.random(in: 0...255) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
//    @IBAction private func tappedChangeColorButton(_ sender: Any) {
//        AMPrefecture.allCases.forEach {
//            detailView.setFillColor(color: randomColor(alpha: 1.0), prefecture: $0)
//        }
}

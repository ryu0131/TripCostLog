//
//  MoneyDetailViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2021/01/11.
//

import UIKit
import RealmSwift

class MoneyDetailViewController: UIViewController, UITextViewDelegate {

    var payData: Results<PayDataObject>!
    
    @IBOutlet var memo: UILabel!
    @IBOutlet var money: UILabel!
    @IBOutlet var payNumber: UILabel!
    @IBOutlet var oneMoney: UILabel!
    @IBOutlet var payDayLabel: UILabel!
    @IBOutlet var moneyLabel: UILabel!
    @IBOutlet var payNumberLabel: UILabel!
    @IBOutlet var onePayLabel: UILabel!
    @IBOutlet var textView: UITextView!
    
    var receiveTitle: String!
    var receiveMoney: String!
    var receiveId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        payData = realm.objects(PayDataObject.self)
  
        payDayLabel.text = "・" + receiveTitle
        moneyLabel.text = receiveMoney
        copyText()
        
        textView.delegate = self
        view.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)
        
        payDayLabel.layer.cornerRadius = 5.0
        payDayLabel.clipsToBounds = true
        memo.layer.cornerRadius = 5.0
        memo.clipsToBounds = true
        textView.layer.cornerRadius = 5.0
        textView.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        memo.adjustsFontSizeToFitWidth = true
        money.adjustsFontSizeToFitWidth = true
        payNumber.adjustsFontSizeToFitWidth = true
        oneMoney.adjustsFontSizeToFitWidth = true
        payDayLabel.adjustsFontSizeToFitWidth = true
        moneyLabel.adjustsFontSizeToFitWidth = true
        payNumberLabel.adjustsFontSizeToFitWidth = true
        oneMoney.adjustsFontSizeToFitWidth = true
        
    }
    
    func copyText() {
        for i in 0..<payData.count {
            if receiveId == payData[i].id2 {
                payNumberLabel.text = payData[i].paynumber
                textView.text = payData[i].memo
                onePayLabel.text = "\(Int(receiveMoney.dropLast())! / Int(payNumberLabel.text!.dropLast())!)" + "円"
            }
            
        }
    }
    
    
}

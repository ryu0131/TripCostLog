//
//  SecondAddViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/12/01.
//

import UIKit
import RealmSwift

class SecondAddViewController: UIViewController {

    @IBOutlet var saveButton: UIButton!
    
    var tripData: Results<TripDataObject>!
    var shareNumber:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        tripData = realm.objects(TripDataObject.self)
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        shareNumber = appDelegate.sharedNumber
        view.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)
        
        self.saveButton.layer.cornerRadius = 10.0
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.secondMoney = nil
        appDelegate.secondMemo = nil
        appDelegate.secondDay = nil
        appDelegate.secondPayNumber = nil
    }
    
    override func viewDidLayoutSubviews() {
        saveButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func save() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if  appDelegate.secondMoney == nil || appDelegate.secondDay == nil || appDelegate.secondPayNumber == nil || appDelegate.secondMoney == 0 || appDelegate.secondPayNumber == "" || appDelegate.secondDay == nil {

            let alert: UIAlertController = UIAlertController(title: "Error", message: "空欄があります。記入してください。", preferredStyle: .alert)
        
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
        })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
            
        //宣言っぽいやつ
        let realm = try! Realm()
        //クラスを作る
        let secaddrealm = PayDataObject.create()
    
        //実体化　インスタンス化
            secaddrealm.money = appDelegate.secondMoney
            secaddrealm.memo = appDelegate.secondMemo
            secaddrealm.day = appDelegate.secondDay
            secaddrealm.paynumber = appDelegate.secondPayNumber
            secaddrealm.name = tripData[shareNumber].name!
        
           // データをRealmに持っていく
        try! realm.write {
            realm.add(secaddrealm)
            }
        }
        navigationController?.popViewController(animated: true)
    }

}

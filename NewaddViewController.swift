//
//  newaddViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/11/25.
//

import UIKit
import RealmSwift

class NewaddViewController: UIViewController{
 
    @IBOutlet var containView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    var recognizeNumber: String!
    var tripData: Results<TripDataObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saveButton.layer.cornerRadius = 10.0
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        view.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)
        self.view.addSubview(saveButton)

    }
  
    override func viewDidLayoutSubviews() {

        saveButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func save() {
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        if  appDelegate.newAddName == "" || appDelegate.newAddStartDay == "" || appDelegate.newAddPeople == "" || appDelegate.newAddReturnDay == "" {
                
                let alert: UIAlertController = UIAlertController(title: "Error", message: "空欄があります。記入してください。", preferredStyle: .alert)
            
                let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
            })
                alert.addAction(defaultAction)
                present(alert, animated: true, completion: nil)
        } else {
            
            let realm = try! Realm()
            tripData = realm.objects(TripDataObject.self)
            
            
            let person = realm.objects(TripDataObject.self).sorted(byKeyPath: "id", ascending: true).last
            
            if person == nil {
                recognizeNumber = appDelegate.newAddName + "idd1"
            } else {
                recognizeNumber = appDelegate.newAddName + "idd\(person!.id + 1)"
            }
            //からのクラスを作る
            let addrealm = TripDataObject.create()
            
            
            addrealm.name = recognizeNumber
            addrealm.startDay = appDelegate.newAddStartDay
            addrealm.people = appDelegate.newAddPeople
            addrealm.returnDay = appDelegate.newAddReturnDay
            
            // データをRealmに持っていく
            try! realm.write {
                realm.add(addrealm)
            }
            navigationController?.popViewController(animated: true)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}



//
//  addObject.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/12/01.
//
import Foundation
import RealmSwift

class PayDataObject: Object {
    static let realm = try! Realm()
    
    @objc dynamic var money: Int = 0
    @objc dynamic var memo: String? = nil
    @objc dynamic var paynumber: String? = nil
    @objc dynamic var day: String? = nil
    @objc dynamic var name: String? = nil
    @objc dynamic var id2: Int = 0



    override static func primaryKey() -> String? {
        return "id2"
    }

    //id更新
    static func create() -> PayDataObject {
        let customMemo2 = PayDataObject()
        customMemo2.id2 = newID()
        return customMemo2
    }
    // ID を increment して返す
    static func newID() -> Int {
        if let person2 = realm.objects(PayDataObject.self).sorted(byKeyPath: "id2", ascending: true).last {
            return person2.id2 + 1
        } else {
            return 1
        }
    }
}

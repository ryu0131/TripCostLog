//
//  addRealm.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/11/30.
//
import Foundation
import RealmSwift

class TripDataObject: Object {
    
    static let realm = try! Realm()
    
    @objc dynamic var name: String? = nil
    @objc dynamic var startDay: String? = nil
    @objc dynamic var returnDay: String? = nil
    @objc dynamic var people: String? = nil
    @objc dynamic var id: Int = 0
    @objc dynamic var oneImage: NSData? = nil
    @objc dynamic var twoImage: NSData? = nil
    @objc dynamic var threeImage: NSData? = nil
    @objc dynamic var fourImage: NSData? = nil
    dynamic var order = 0
    
       override static func primaryKey() -> String? {
           return "id"
       }
    
    //id更新
    static func create() -> TripDataObject {
        let customMemo = TripDataObject()
        customMemo.id = newID()
        return customMemo
    }
       // ID を increment して返す
       static func newID() -> Int {
           if let person = realm.objects(TripDataObject.self).sorted(byKeyPath: "id", ascending: true).last {
               return person.id + 1
           } else {
               return 1
           }
       }
    //消す
    static func deleteAll() {
        let memos = realm.objects(TripDataObject.self)
        try! realm.write {
            realm.delete(memos)
        }
    }

    //save
    func save() {
        try! TripDataObject.realm.write {
            TripDataObject.realm.add(self)
        }
    }

}

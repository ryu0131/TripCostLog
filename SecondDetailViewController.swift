//
//  SecondDetailViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/12/03.
//
import UIKit
import RealmSwift

class SecondDetailViewContoroller: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandedHeaderViewDelegate {
   

    @IBOutlet var tableView: UITableView!
    @IBOutlet var allTextField: UITextField!
    
    var payData: Results<PayDataObject>!
    var tripData: Results<TripDataObject>!
    var passData2 = 0
    var total:Int = 0
    var passId = 0
    var passMoney: String!
    var passTitle: String!
    var ddlist = [String]()

    var sections = [
        Section(title: "1日目", elements: [],expanded: false, idArray: []),
        Section(title: "2日目", elements: [],expanded: false, idArray: []),
        Section(title: "3日目", elements: [],expanded: false, idArray: []),
        Section(title: "4日目", elements: [],expanded: false, idArray: []),
        Section(title: "5日目", elements: [],expanded: false, idArray: []),
        Section(title: "6日目", elements: [],expanded: false, idArray: [])
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()

        payData = realm.objects(PayDataObject.self)
        tripData = realm.objects(TripDataObject.self)
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        passData2 = appDelegate.sharedNumber
        view.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)

        if tableView == nil {
        } else {
        tableView.tableFooterView = UIView()
        }
    }


    
    override func viewWillAppear(_ animated: Bool) {
    
        plusMoney()
        allTextField.text = "\(total)"
        //arrayにデータを入れる
        for j in 0..<6 {
            self.sections[j].idArray = []
        }
        
        for j in 0..<6 {
            self.sections[j].elements = []
        }
   
        for i in 0..<payData.count {
            if tripData[passData2].name! == payData[i].name! {
                if payData[i].day! == "1日目" {
                    self.sections[0].elements.append(String(payData[i].money)  + "円")
                    self.sections[0].idArray.append(payData[i].id2)
                } else if payData[i].day! == "2日目" {
                    self.sections[1].elements.append(String(payData[i].money) + "円")
                    self.sections[1].idArray.append(payData[i].id2)
                } else if payData[i].day! == "3日目" {
                    self.sections[2].elements.append(String(payData[i].money) + "円")
                    self.sections[2].idArray.append(payData[i].id2)
                } else if payData[i].day! == "4日目" {
                    self.sections[3].elements.append(String(payData[i].money) + "円")
                    self.sections[3].idArray.append(payData[i].id2)
                } else if payData[i].day! == "5日目" {
                    self.sections[4].elements.append(String(payData[i].money) + "円")
                    self.sections[4].idArray.append(payData[i].id2)
                } else if payData[i].day! == "6日目" {
                    self.sections[5].elements.append(String(payData[i].money) + "円")
                    self.sections[5].idArray.append(payData[i].id2)
                }
            }
        }
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy/M/d"
        let day1:Date = myDateFormatter.date(from: "\(tripData[passData2].startDay!)")!
        let day2:Date = myDateFormatter.date(from: "\(tripData[passData2].returnDay!)")!
        let dayInterval = (Calendar.current.dateComponents([.day], from: day1, to: day2)).day
        return dayInterval! + 1
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].elements.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let size = tableView.bounds.size
        let autoWidth = size.height
        
        return 60*autoWidth/586
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !sections[indexPath.section].expanded {
            let size = tableView.bounds.size
            let autoWidth = size.height
            return 55*autoWidth/586
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandedHeaderView()
        header.customInit(title: sections[section].title, section: section, delegate: self)

        return header
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].elements[indexPath.row] as? String
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        passMoney = sections[indexPath.section].elements[indexPath.row]
        passId = sections[indexPath.section].idArray[indexPath.row]
        passTitle = sections[indexPath.section].title!
        
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "detailNext", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailNext" {
            // ③遷移先ViewCntrollerの取得
            let nextView = segue.destination as! MoneyDetailViewController
            // ④値の設定
            nextView.receiveMoney = passMoney
            nextView.receiveTitle = passTitle
            nextView.receiveId = passId
        }
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            //アラートを表示する↓＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
            let alert: UIAlertController = UIAlertController(title: "注意", message: "削除してもいいですか？", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "キャンセル", style: .default)
            let okAction = UIAlertAction(title: "OK", style: .destructive) { (action: UIAlertAction) in
                
                //「削除」が押された時の処理をここに記述
                self.sections[indexPath.section].elements.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                let realm = try! Realm()
                let object = realm.object(ofType: PayDataObject.self, forPrimaryKey: self.self.sections[indexPath.section].idArray[indexPath.row])
                
                if object == nil {
                    
                } else {
                    try! realm.write {
                        realm.delete(object!)
                    }
                }
                
                self.plusMoney()
                self.allTextField.text = "\(self.total)"
                self.allTextField.reloadInputViews()
            }
            
            if UIDevice.current.userInterfaceIdiom == .pad{
                alert.popoverPresentationController?.sourceView = self.view
                let screenSize = UIScreen.main.bounds
                alert.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
            }
            
            //アラートに設定を反映させる
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            //アラート画面を表示させる
            self.present(alert, animated: true, completion: nil)
        }
        
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton]
        self.tableView.reloadData()
    }

  
    func toggleSection(header: ExpandedHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded

        tableView.beginUpdates()

        for i in 0 ..< sections[section].elements.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }

        tableView.endUpdates()
        }
    
    //お金を計算
    func plusMoney() {
        total = 0
        for i in 0..<payData.count {
            if tripData[passData2].name! == payData[i].name! {
                if payData[i].paynumber == "" {
                    
                } else {
                    let a:Int = payData[i].money / Int(payData[i].paynumber!.dropLast())!
                    total += a
                }
            }
        }
    }
    
}


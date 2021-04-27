//
//  SecAddTableViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2021/01/10.
//

import UIKit
import RealmSwift

class SecAddTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var moneyLabel: UILabel!
    @IBOutlet var payNumberLabel: UILabel!
    @IBOutlet var payDayLabel: UILabel!
    @IBOutlet var memoLabel: UILabel!
    @IBOutlet var moneyTextField: UITextField!
    @IBOutlet var dayTextField: UITextField!
    @IBOutlet var paynumberTextField: UITextField!
    @IBOutlet var memoTextField: UITextField!
    
    var upperPickerView: UIPickerView = UIPickerView()
    var lowerPickerView = UIPickerView()
    
    let list = ["", "1人", "2人", "3人", "4人", "5人", "6人", "7人", "8人", "9人", "10人"]
    let daylist = ["", "1日目","2日目", "3日目", "4日目", "5日目", "6日目"]
    
    var tripData: Results<TripDataObject>!
    var shareNumber:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moneyTextField.delegate = self
        memoTextField.delegate = self
        
        createPickerView()
        let realm = try! Realm()
        tripData = realm.objects(TripDataObject.self)
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        shareNumber = appDelegate.sharedNumber
        
        tableView.allowsSelection = false
        
        tableView.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20.0) // フォントサイズ：20
        ]
        
        moneyTextField.attributedPlaceholder = NSAttributedString(string: "払った金額", attributes: attributes)
        paynumberTextField.attributedPlaceholder = NSAttributedString(string: "◯人", attributes: attributes)
        dayTextField.attributedPlaceholder = NSAttributedString(string: "◯日目", attributes: attributes)
        memoTextField.attributedPlaceholder = NSAttributedString(string: "使用した場所、物など", attributes: attributes)
        moneyTextField.keyboardType = .numberPad
        let screenRect = UIScreen.main.bounds
        tableView.frame = CGRect(x: 0, y: 0, width: screenRect.width, height: screenRect.height)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.secondDay = nil
        appDelegate.secondMemo = nil
        appDelegate.secondMoney = nil
        appDelegate.secondPayNumber = nil
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    
    func createPickerView() {
        // upperPickerView
        upperPickerView.delegate = self
        paynumberTextField.inputView = upperPickerView
        // toolbar
        let upperToolbar = UIToolbar()
        upperToolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let upperDoneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        upperToolbar.setItems([upperDoneButtonItem], animated: true)
        paynumberTextField.inputAccessoryView = upperToolbar
        
        // lowerPickerView
        lowerPickerView.delegate = self
        dayTextField.inputView = lowerPickerView
        // toolbar
        let lowerToolbar = UIToolbar()
        lowerToolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let lowerDoneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        lowerToolbar.setItems([lowerDoneButtonItem], animated: true)
        dayTextField.inputAccessoryView = lowerToolbar
    }
    
    @objc func donePicker() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.secondDay = dayTextField.text!
        appDelegate.secondPayNumber = paynumberTextField.text!
        
        paynumberTextField.endEditing(true)
        dayTextField.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        paynumberTextField.endEditing(true)
        dayTextField.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == upperPickerView {
            let realm = try! Realm()
            tripData = realm.objects(TripDataObject.self)
            return Int(tripData[shareNumber].people!.dropLast())! + 1
        } else {
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "yyyy/M/d"
            let day1:Date = myDateFormatter.date(from: "\(tripData[shareNumber].startDay!)")!
            let day2:Date = myDateFormatter.date(from: "\(tripData[shareNumber].returnDay!)")!
            let dayInterval = (Calendar.current.dateComponents([.day], from: day1, to: day2)).day
            
            return dayInterval! + 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == upperPickerView {
            return list[row]
        } else {
            return daylist[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == upperPickerView {
            paynumberTextField.text = list[row]
        } else {
            dayTextField.text = daylist[row]
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true) //キーボード閉じる
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if moneyTextField.text == nil {
            
        } else {
            appDelegate.secondMoney = Int(moneyTextField.text!) ?? 0
        }
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if memoTextField.text == nil {
            
        } else {
            appDelegate.secondMemo = memoTextField.text!
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let size = tableView.bounds.size.height
        return 55*size/330
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

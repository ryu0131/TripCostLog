//
//  NewAddTableViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2021/01/09.
//

import UIKit
import RealmSwift

class NewAddTableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var tripData: Results<TripDataObject>!
    @IBOutlet var tripNameLabel: UILabel!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var returnLabel: UILabel!
    @IBOutlet var peopleLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var startDayTextField: UITextField!
    @IBOutlet var returnDayTextField: UITextField!
    @IBOutlet var peopleTextField: UITextField!
    @IBOutlet var textView: UITextView!
    
    
    var datePicker: UIDatePicker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    let list = ["", "1人", "2人", "3人", "4人", "5人", "6人", "7人", "8人", "9人", "10人"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.allowsSelection = false
        nameTextField.delegate = self
        
        createPickerView()
        createDatePicker()
        create2DatePicker()
        placeholderChange()
        
        tableView.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)

        
        let tableFooterView = UIView(frame: CGRect.zero)
        tableView.tableFooterView = tableFooterView
    }
    
    
  
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
              return 4
            default:
              return 0
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.newAddName = ""
        appDelegate.newAddPeople = ""
        appDelegate.newAddReturnDay = ""
        appDelegate.newAddStartDay = ""
        stopText()
    }
    

    func createPickerView() {
            // upperPickerView作成
            pickerView.delegate = self
            peopleTextField.inputView = pickerView
            // toolbar作成
            let Toolbar = UIToolbar()
            Toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
            let DoneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
            Toolbar.setItems([DoneButtonItem], animated: true)
            peopleTextField.inputAccessoryView = Toolbar

        }

        @objc func donePicker() {
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.newAddPeople = peopleTextField.text!
            peopleTextField.endEditing(true)
        }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            peopleTextField.endEditing(true)
        }


        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

                return list.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

                return list[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
                peopleTextField.text = list[row]
        }

    
    func createDatePicker(){
        
        // DatePickerModeをDate(日付)に設定
        datePicker.datePickerMode = .date
        
        // DatePickerを日本語化
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        
        // textFieldのinputViewにdatepickerを設定
        startDayTextField.inputView = datePicker
        
        
        
        datePicker.preferredDatePickerStyle = .wheels
        // UIToolbarを設定
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))        //         toolbar.sizeToFit()
        
        // Doneボタンを設定(押下時doneClickedが起動)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        // Doneボタンを追加
        toolBar.setItems([doneButton], animated: true)
        
        // FieldにToolbarを追加
        startDayTextField.inputAccessoryView = toolBar
        
        
        
    }
    
    @objc func doneClicked(){
        let dateFormatter = DateFormatter()
        
        // 持ってくるデータのフォーマットを設定
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale    = NSLocale(localeIdentifier: "ja_JP") as Locale?
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        // textFieldに選択した日付を代入
        startDayTextField.text = dateFormatter.string(from: datePicker.date)
        stopText()
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.newAddStartDay = startDayTextField.text!
        // キーボードを閉じる
        self.view.endEditing(true)
        
    }
    
    func create2DatePicker(){
        
        // DatePickerModeをDate(日付)に設定
        datePicker.datePickerMode = .date
        
        // DatePickerを日本語化
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        
        if startDayTextField.text == nil {
            let alert: UIAlertController = UIAlertController(title: "Error", message: "出発日を入力してください", preferredStyle: .alert)
        
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
        })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
        // textFieldのinputViewにdatepickerを設定
        returnDayTextField.inputView = datePicker
            
        }
        
        
        datePicker.preferredDatePickerStyle = .wheels
        // UIToolbarを設定
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))        //         toolbar.sizeToFit()
        
        // Doneボタンを設定(押下時doneClickedが起動)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done2Clicked))
        
        // Doneボタンを追加
        toolBar.setItems([doneButton], animated: true)
        
        // FieldにToolbarを追加
        returnDayTextField.inputAccessoryView = toolBar
    }
        
    
    @objc func done2Clicked(){
        
        let dateFormatter = DateFormatter()
        
        // 持ってくるデータのフォーマットを設定
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale    = NSLocale(localeIdentifier: "ja_JP") as Locale?
        dateFormatter.dateStyle = DateFormatter.Style.medium
       
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy/M/d"
        
        let day1:Date = myDateFormatter.date(from: "\(startDayTextField.text!)")!
      
        let day2:Date = myDateFormatter.date(from: "\(dateFormatter.string(from: datePicker.date))")!
            
        let dayInterval = (Calendar.current.dateComponents([.day], from: day1, to: day2)).day
        //print(dayInterval!)
        
        if dayInterval! < 0  {
            let alert: UIAlertController = UIAlertController(title: "Error", message: "出発日より後にしてください", preferredStyle: .alert)
        
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
        })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else if dayInterval! >= 6{
            let alert: UIAlertController = UIAlertController(title: "Error", message: "6泊以上は選択できません", preferredStyle: .alert)
        
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
        })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
            // textFieldに選択した日付を代入
            returnDayTextField.text = dateFormatter.string(from: datePicker.date)
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.newAddReturnDay = returnDayTextField.text!
            // キーボードを閉じる
            self.view.endEditing(true)
        }
    }
    
     func stopText() {
        
        if startDayTextField.text == "" {
            returnDayTextField.placeholder = "出発日から入力してください"
            returnDayTextField.isEnabled = false
            
        } else {
            returnDayTextField.isEnabled = true
            returnDayTextField.placeholder = "帰着日を入力してください"
        }
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //samenameError()
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.newAddName = nameTextField.text!
    }
    
    func placeholderChange() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy/M/d", options: 0, locale: Locale(identifier: "ja_JP"))
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20.0) // フォントサイズ：20、太さ：bold
            ]
        
        peopleTextField.attributedPlaceholder = NSAttributedString(string: "旅行人数", attributes: attributes)
        nameTextField.attributedPlaceholder = NSAttributedString(string: "タイトル", attributes: attributes)
        returnDayTextField.attributedPlaceholder = NSAttributedString(string: "出発日から記入してください", attributes: attributes)
        startDayTextField.attributedPlaceholder = NSAttributedString(string: "\(dateFormatter.string(from: now))", attributes: attributes)
    }
    
    func samenameError() {
        
        let realm = try! Realm()
        tripData = realm.objects(TripDataObject.self)
        for i in 0..<tripData.count {
            if nameTextField.text! == tripData[i].name {
                let alert: UIAlertController = UIAlertController(title: "同じ旅行名があります。", message: "他の名前で入力してください", preferredStyle: .alert)
                
                let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{ (action) in
                    alert.dismiss(animated: true, completion: nil)
                })
                alert.addAction(defaultAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let size = tableView.bounds.size.height
        return 55*size/250
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}

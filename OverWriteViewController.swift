//
//  attemptViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/12/04.
//

import UIKit
import RealmSwift
import DKImagePickerController


class OverWriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate  {

    var passData = 0
    var recognizeName: String!
    var selectImage = [UIImage]()
    
    var datePicker: UIDatePicker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    
    let list = ["", "1人", "2人", "3人", "4人", "5人", "6人", "7人", "8人", "9人", "10人"]

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var startDayTextField: UITextField!
    @IBOutlet var returnDayTextField: UITextField!
    @IBOutlet var peopleTextField: UITextField!
    @IBOutlet weak var selectedOneImageView: UIImageView!
    @IBOutlet weak var selectedTwoImageView: UIImageView!
    @IBOutlet weak var selectedThreeImageView: UIImageView!
    @IBOutlet weak var selectedFourImageView: UIImageView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var selectButton: UIButton!
    @IBOutlet var image1Label: UILabel!
    @IBOutlet var image2Label: UILabel!
    @IBOutlet var image3Label: UILabel!
    @IBOutlet var image4Label: UILabel!

    
   var tripData: Results<TripDataObject>!
   var payData: Results<PayDataObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)
        let realm = try! Realm()
        tripData = realm.objects(TripDataObject.self)
        
        nameTextField.delegate = self
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        passData = appDelegate.sharedNumber

        
        var str = "\(tripData[passData].name!)"
         
        let result = str.range(of: "idd\(tripData[passData].id)")
        if let theRange = result {
            str.removeSubrange(theRange)
            
            selectedOneImageView.layer.borderWidth = 0.5
            selectedTwoImageView.layer.borderWidth = 0.5
            selectedThreeImageView.layer.borderWidth = 0.5
            selectedFourImageView.layer.borderWidth = 0.5
            
            selectedOneImageView.layer.borderColor = #colorLiteral(red: 0.4072262049, green: 0.4072262049, blue: 0.4072262049, alpha: 1).cgColor
            selectedTwoImageView.layer.borderColor = #colorLiteral(red: 0.4072262049, green: 0.4072262049, blue: 0.4072262049, alpha: 1).cgColor
            selectedThreeImageView.layer.borderColor = #colorLiteral(red: 0.4072262049, green: 0.4072262049, blue: 0.4072262049, alpha: 1).cgColor
            selectedFourImageView.layer.borderColor = #colorLiteral(red: 0.4072262049, green: 0.4072262049, blue: 0.4072262049, alpha: 1).cgColor
            
        }
        
        nameTextField.text = str
        startDayTextField.text = tripData[passData].startDay
        peopleTextField.text = tripData[passData].people
        returnDayTextField.text = tripData[passData].returnDay
        
        createPickerView()
        createDatePicker()
        create2DatePicker()

    }
    
    override func viewDidLayoutSubviews() {
        borderLine()
        selectButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addButton.titleLabel?.adjustsFontSizeToFitWidth = true
        deleteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        image1Label.adjustsFontSizeToFitWidth = true
        image2Label.adjustsFontSizeToFitWidth = true
        image3Label.adjustsFontSizeToFitWidth = true
        image4Label.adjustsFontSizeToFitWidth = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        algorithm()
    }
    
    
    @IBAction func selectImage(sender: AnyObject) {
        selectImage = []
        self.pickImages()
        
    }
    
    // 写真を選択する
    func pickImages() {
        let picker = DKImagePickerController()
        
        //選択できる写真の最大数を指定
        picker.maxSelectableCount = 4
        //カメラモード、写真モードの選択
        picker.sourceType = .photo
        //キャンセルボタンの有効化
        picker.showsCancelButton = true
        //UIのカスタマイズ（CustomUIDelegateクラスを使う）
        picker.UIDelegate = CustomUIDelegate()
        
        // 追加した文
        picker.didSelectAssets = { (assets: [DKAsset]) in
            
            for asset in assets {
                
                asset.fetchOriginalImage(completeBlock: {(image, info) in

                    self.selectImage.append(image!)
                    
                    if self.selectImage.count == 1 {
                        self.selectedOneImageView.image = self.selectImage[0]
                        self.selectedTwoImageView.image = nil
                        self.selectedThreeImageView.image = nil
                        self.selectedFourImageView.image = nil
                        self.image1Label.text = ""
                        self.image2Label.text = "画像２"
                        self.image3Label.text = "画像３"
                        self.image4Label.text = "画像４"
                        
                    } else if self.selectImage.count == 2 {
                        self.selectedOneImageView.image = self.selectImage[0]
                        self.selectedTwoImageView.image = self.selectImage[1]
                        self.selectedThreeImageView.image = nil
                        self.selectedFourImageView.image = nil
                        self.image1Label.text = ""
                        self.image2Label.text = ""
                        self.image3Label.text = "画像３"
                        self.image4Label.text = "画像４"
                        
                    } else if self.selectImage.count == 3 {
                        
                        self.selectedOneImageView.image = self.selectImage[0]
                        self.selectedTwoImageView.image = self.selectImage[1]
                        self.selectedThreeImageView.image = self.selectImage[2]
                        self.selectedFourImageView.image = nil
                        self.image1Label.text = ""
                        self.image2Label.text = ""
                        self.image3Label.text = ""
                        self.image4Label.text = "画像４"
                        
                    } else if self.selectImage.count == 4 {
                        self.selectedOneImageView.image = self.selectImage[0]
                        self.selectedTwoImageView.image = self.selectImage[1]
                        self.selectedThreeImageView.image = self.selectImage[2]
                        self.selectedFourImageView.image = self.selectImage[3]
                        self.image1Label.text = ""
                        self.image2Label.text = ""
                        self.image3Label.text = ""
                        self.image4Label.text = ""
                        
                    }
                    //print(image!)
                })
            }
        }
        self.present(picker, animated: true, completion: nil)
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
        
        // キーボードを閉じる
        self.view.endEditing(true)
    }
    
    func create2DatePicker(){
        
        // DatePickerModeをDate(日付)に設定
        datePicker.datePickerMode = .date
        
        // DatePickerを日本語化
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        
        // textFieldのinputViewにdatepickerを設定
        returnDayTextField.inputView = datePicker
        
        
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
    
    
    
    @IBAction func delete() {
        //アラートを表示する
        let alert: UIAlertController = UIAlertController(title: "注意", message: "削除してもいいですか？", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default)
        let okAction = UIAlertAction(title: "OK", style: .destructive) { (action: UIAlertAction) in
            
            let realm = try! Realm()
            
            // 「削除」が押された時の処理をここに記述
            let object = realm.object(ofType: TripDataObject.self, forPrimaryKey: self.tripData[self.passData].id)
         
            self.payData = realm.objects(PayDataObject.self)
            // (2)クエリによるデータの取得
            let results = realm.objects(PayDataObject.self).filter("name == '\(object!.name!)'")
            // (3)データの削除
            try! realm.write {
                realm.delete(object!)
                realm.delete(results)
            }

            self.navigationController?.popViewController(animated: true)
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
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func updata() {
                                    
        let one = self.selectedOneImageView.image
        let two = self.selectedTwoImageView.image
        let three = self.selectedThreeImageView.image
        let four = self.selectedFourImageView.image
        
        //宣言っぽいやつ
        let realm = try! Realm()
        
        payData = realm.objects(PayDataObject.self)
        
        try! realm.write {
            
            for i in 0..<payData.count {
                if self.tripData[passData].name == payData[i].name {
                    payData[i].name = self.nameTextField.text! + "idd\(self.tripData[passData].id)"
                }
            }
        }
        
        // データをRealmに持っていく(リサイズする)
        try! realm.write {
            
            if one == nil
                && two == nil
                && three == nil
                && four == nil {
                self.tripData[passData].oneImage = nil
                self.tripData[passData].twoImage = nil
                self.tripData[passData].threeImage = nil
                self.tripData[passData].fourImage = nil
                
            } else if two == nil
                        && three == nil
                        && four == nil {
                let data1 = one!.resize(200)!.pngData()
                self.tripData[passData].oneImage = data1! as NSData
                self.tripData[passData].twoImage = nil
                self.tripData[passData].threeImage = nil
                self.tripData[passData].fourImage = nil
            } else if three == nil
                        && four == nil {
                
                let data1 = one!.resize(200)!.pngData()
                let data2 = two!.resize(200)!.pngData()
                self.tripData[passData].oneImage = data1! as NSData
                self.tripData[passData].twoImage = data2! as NSData
                self.tripData[passData].threeImage = nil
                self.tripData[passData].fourImage = nil
            } else if four == nil {
                
                let data1 = one!.resize(200)!.pngData()
                let data2 = two!.resize(200)!.pngData()
                let data3 = three!.resize(200)!.pngData()
                self.tripData[passData].oneImage = data1! as NSData
                self.tripData[passData].twoImage = data2! as NSData
                self.tripData[passData].threeImage = data3! as NSData
                self.tripData[passData].fourImage = nil
                
            } else {
                
                let data1 = one!.resize(200)!.pngData()
                let data2 = two!.resize(200)!.pngData()
                let data3 = three!.resize(200)!.pngData()
                let data4 = four!.resize(200)!.pngData()
                self.tripData[passData].oneImage = data1! as NSData
                self.tripData[passData].twoImage = data2! as NSData
                self.tripData[passData].threeImage = data3! as NSData
                self.tripData[passData].fourImage = data4! as NSData
            }
            
            let realm = try! Realm()
            tripData = realm.objects(TripDataObject.self)
            
            recognizeName = self.nameTextField.text! + "idd\(self.tripData[passData].id)"
            
            
            self.tripData[passData].name = recognizeName
            self.tripData[passData].startDay = self.startDayTextField.text!
            self.tripData[passData].people = self.peopleTextField.text!
            self.tripData[passData].returnDay = self.returnDayTextField.text!
            
        }
        navigationController?.popViewController(animated: true)
    }
    
   
    func algorithm() {
        
        if tripData[passData].fourImage == nil
            && tripData[passData].threeImage == nil
            && tripData[passData].twoImage == nil
            && tripData[passData].oneImage == nil{
            image1Label.text = "画像１"
            image2Label.text = "画像２"
            image3Label.text = "画像３"
            image4Label.text = "画像４"
            
        } else if tripData[passData].fourImage == nil
               && tripData[passData].threeImage == nil
               && tripData[passData].twoImage == nil {
            
            selectedOneImageView.image = UIImage(data: tripData[passData].oneImage! as Data)
            self.selectedTwoImageView.image = nil
            self.selectedThreeImageView.image = nil
            self.selectedFourImageView.image = nil
            image1Label.text = ""
            image2Label.text = "画像２"
            image3Label.text = "画像３"
            image4Label.text = "画像４"
            
        } else if tripData[passData].fourImage == nil
               && tripData[passData].threeImage == nil {
            
            selectedOneImageView.image = UIImage(data: tripData[passData].oneImage! as Data)
            selectedTwoImageView.image = UIImage(data: tripData[passData].twoImage! as Data)
            self.selectedThreeImageView.image = nil
            self.selectedFourImageView.image = nil
            image1Label.text = ""
            image2Label.text = ""
            image3Label.text = "画像３"
            image4Label.text = "画像４"
            
        } else if tripData[passData].fourImage == nil {
            
            selectedOneImageView.image = UIImage(data: tripData[passData].oneImage! as Data)
            selectedTwoImageView.image = UIImage(data: tripData[passData].twoImage! as Data)
            selectedThreeImageView.image = UIImage(data: tripData[passData].threeImage! as Data)
            self.selectedFourImageView.image = nil
            image1Label.text = ""
            image2Label.text = ""
            image3Label.text = ""
            image4Label.text = "画像４"
            
        } else {
            
            selectedOneImageView.image = UIImage(data: tripData[passData].oneImage! as Data)
            selectedTwoImageView.image = UIImage(data: tripData[passData].twoImage! as Data)
            selectedThreeImageView.image = UIImage(data: tripData[passData].threeImage! as Data)
            selectedFourImageView.image = UIImage(data: tripData[passData].fourImage! as Data)
            image1Label.text = ""
            image2Label.text = ""
            image3Label.text = ""
            image4Label.text = ""
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    
    
    func borderLine() {
        
        self.addButton.layer.cornerRadius = 10.0
        self.deleteButton.layer.cornerRadius = 10.0
        self.selectButton.layer.cornerRadius = 10.0
        self.selectedOneImageView.layer.cornerRadius = 9.0
        self.selectedTwoImageView.layer.cornerRadius = 9.0
        self.selectedThreeImageView.layer.cornerRadius = 9.0
        self.selectedFourImageView.layer.cornerRadius = 9.0
        
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: startDayTextField.frame.size.height - width, width:
                                startDayTextField.frame.size.width, height: 1)
        border.borderWidth = width
    
        let border2 = CALayer()
        let width2 = CGFloat(2.0)
        border2.borderColor = UIColor.gray.cgColor
        border2.frame = CGRect(x: 0, y: returnDayTextField.frame.size.height - width2, width:
                                returnDayTextField.frame.size.width, height: 1)
        border2.borderWidth = width2
        
        let border3 = CALayer()
        let width3 = CGFloat(2.0)
        border3.borderColor = UIColor.gray.cgColor
        border3.frame = CGRect(x: 0, y: peopleTextField.frame.size.height - width3, width:
                                peopleTextField.frame.size.width, height: 1)
        border3.borderWidth = width3
        
        let border4 = CALayer()
        let width4 = CGFloat(2.0)
        border4.borderColor = UIColor.gray.cgColor
        border4.frame = CGRect(x: 0, y: nameTextField.frame.size.height - width4, width:
                                nameTextField.frame.size.width, height: 1)
        border4.borderWidth = width4
        
        let border5 = CALayer()
        let width5 = CGFloat(2.0)
        border5.borderColor = UIColor.gray.cgColor
        border5.frame = CGRect(x: 0, y: 0, width:
                                nameTextField.frame.size.width, height: 1)
        border5.borderWidth = width5

        
        startDayTextField.layer.addSublayer(border)
        returnDayTextField.layer.addSublayer(border2)
        peopleTextField.layer.addSublayer(border3)
        nameTextField.layer.addSublayer(border4)
        nameTextField.layer.addSublayer(border5)
      

    }

    
}

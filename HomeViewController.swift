//
//  homeViewController.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/12/03.
//
import UIKit
import RealmSwift

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    //collectionViewの宣言
    @IBOutlet var homeCollectionView : UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var newSort: UIButton!
    @IBOutlet var oldSort: UIButton!
    
    //var trueList:Results<add12Realm>!
    var tripData: Results<TripDataObject>!
    var sortId = [Int]()
    var number = 0
    var change = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
        let realm = try! Realm()
        searchBar.delegate = self
        tripData = realm.objects(TripDataObject.self)
        //trueList = realm.objects(add12Realm.self)
        
        //nib(カスタムセル)の登録
        let nibname = UINib(nibName: "timelineCollectionViewCell", bundle: Bundle.main)
        homeCollectionView.register(nibname, forCellWithReuseIdentifier: "cell")
        
        homeCollectionView.layer.borderWidth = 1
        homeCollectionView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        
        searchBar.placeholder = "旅行名で検索"
        searchBar.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)
        homeCollectionView.backgroundColor = #colorLiteral(red: 0.953003943, green: 0.8971375823, blue: 0.8103417754, alpha: 1)
        
        //別の場所に触れるとkeyboardが閉じる
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        
        self.tabBarController?.tabBar.barTintColor = #colorLiteral(red: 1, green: 0.6958346963, blue: 0.4786360264, alpha: 0.8470588235)
        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.6958346963, blue: 0.4786360264, alpha: 0.8470588235)
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController!.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    override func viewDidLayoutSubviews() {
        let size = homeCollectionView.bounds.size
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        let averageWidth = size.width/414*190
        let gap = (size.width-averageWidth*2)/3
        layout.sectionInset = UIEdgeInsets(top: gap, left: gap, bottom: 0, right: gap)
        
        homeCollectionView.collectionViewLayout = layout
        
        newSort.titleLabel?.adjustsFontSizeToFitWidth = true
        oldSort.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        change = false
        let realm = try! Realm()
        tripData = realm.objects(TripDataObject.self)
        homeCollectionView.reloadData()
        searchBar.text! = ""
    }
    //配列の個数分セルを生成
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tripData.count
    }
    
    //保存した画像を載せる
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //カスタムセルを扱う時はここのコードはどうする？
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! timeLineCollectionViewCell
        
        if tripData[indexPath.row].fourImage == nil && tripData[indexPath.row].threeImage == nil && tripData[indexPath.row].twoImage == nil && tripData[indexPath.row].oneImage == nil{
            
            cell.threeImageView.image = nil
            cell.fourImageView.image = nil
            cell.twoImageView.image = nil
            cell.oneImageView.image = nil
            
        } else if tripData[indexPath.row].fourImage == nil && tripData[indexPath.row].threeImage == nil && tripData[indexPath.row].twoImage == nil {
            
            let image1 = UIImage(data: tripData[indexPath.row].oneImage! as Data)
            
            cell.threeImageView.image = nil
            cell.fourImageView.image = nil
            cell.twoImageView.image = nil
            cell.oneImageView.image = image1
            
        } else if tripData[indexPath.row].fourImage == nil && tripData[indexPath.row].threeImage == nil {
            
            let image1 = UIImage(data: tripData[indexPath.row].oneImage! as Data)
            let image2 = UIImage(data: tripData[indexPath.row].twoImage! as Data)
            
            cell.threeImageView.image = nil
            cell.fourImageView.image = nil
            cell.oneImageView.image = image1
            cell.twoImageView.image = image2
        } else if tripData[indexPath.row].fourImage == nil {
            
            let image1 = UIImage(data: tripData[indexPath.row].oneImage! as Data)
            let image2 = UIImage(data: tripData[indexPath.row].twoImage! as Data)
            let image3 = UIImage(data: tripData[indexPath.row].threeImage! as Data)
            
            cell.fourImageView.image = nil
            cell.oneImageView.image = image1
            cell.twoImageView.image = image2
            cell.threeImageView.image = image3
        } else {
            
            let image1 = UIImage(data: tripData[indexPath.row].oneImage! as Data)
            let image2 = UIImage(data: tripData[indexPath.row].twoImage! as Data)
            let image3 = UIImage(data: tripData[indexPath.row].threeImage! as Data)
            let image4 = UIImage(data: tripData[indexPath.row].fourImage! as Data)
            cell.oneImageView.image = image1
            cell.twoImageView.image = image2
            cell.threeImageView.image = image3
            cell.fourImageView.image = image4
        }
        var str = "\(tripData[indexPath.row].name!)"
        
        let result = str.range(of: "idd\(tripData[indexPath.row].id)")
        if let theRange = result {
            str.removeSubrange(theRange)
        }
        
        cell.tripNameLabel.text = str
        
        return cell
    }
     //選択したセルのデータを値を渡す
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        if nameList.count == trueList.count {
        //            print("ok")
        //            number = indexPath.row
        //            // セルの選択を解除
        //            collectionView.deselectItem(at: indexPath, animated: true)
        //            let nextVC = storyboard?.instantiateViewController(withIdentifier: "ParchimentViewController") as! ParchimentViewController
        //            // 値を渡す
        //            nextVC.passData = number
        //            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //            appDelegate.sharedNumber = number
        //            performSegue(withIdentifier: "toNext", sender: nil)
        //
        //        } else {
        //            print("No")
        for i in 0..<tripData.count {
            if tripData[indexPath.row].id == tripData[i].id {
                number = i
                // セルの選択を解除
                collectionView.deselectItem(at: indexPath, animated: true)

                let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                if change {
                    appDelegate.sharedNumber = tripData.count - number - 1
                } else {
                    appDelegate.sharedNumber = number
                }
                performSegue(withIdentifier: "toNext", sender: nil)
            }
        }
    }
    
    @IBAction func newOrder() {
        let realm = try! Realm()
        tripData = realm.objects(TripDataObject.self).sorted(byKeyPath: "id", ascending: false)
        change = true
        homeCollectionView.reloadData()
    }
    
    @IBAction func oldOrder() {
        let realm = try! Realm()
        tripData = realm.objects(TripDataObject.self).sorted(byKeyPath: "id", ascending: true)
        change = false
        homeCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let realm = try! Realm()
        tripData = realm.objects(TripDataObject.self).filter("name LIKE '*\(searchBar.text!)*'")
        homeCollectionView.reloadData()
        
        if searchText.isEmpty {
            
            let realm = try! Realm()
            tripData = realm.objects(TripDataObject.self)
            homeCollectionView.reloadData()
            DispatchQueue.main.async { searchBar.resignFirstResponder() }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = UICollectionViewFlowLayout()
        let size = homeCollectionView.bounds.size
        layout.itemSize = CGSize(width: size.width/414*190, height: size.height/655*210)
        
        return CGSize(width: size.width/414*190, height: size.height/655*210)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    //アニメーション
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: {
            cell.alpha = 1
        }, completion: nil)
    }
    
}

//
//  timelineCollectionViewCell.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/12/03.
//
import UIKit
import RealmSwift

//カスタムセルはコード書いておきました。
class timeLineCollectionViewCell: UICollectionViewCell {
    
    //カスタムセル上のUI
    @IBOutlet var oneImageView : UIImageView!
    @IBOutlet var twoImageView : UIImageView!
    @IBOutlet var threeImageView : UIImageView!
    @IBOutlet var fourImageView : UIImageView!
    @IBOutlet var tripNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        oneImageView.layer.borderWidth = 0.3
        twoImageView.layer.borderWidth = 0.3
        threeImageView.layer.borderWidth = 0.3
        fourImageView.layer.borderWidth = 0.3
        
        oneImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        twoImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        threeImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        fourImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
            
        self.tripNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.tripNameLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //cellの枠の幅
        self.layer.borderWidth = 1.0
        // cellの枠の色
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        // cellを丸くする
        self.layer.cornerRadius = 8.0
        
        tripNameLabel.adjustsFontSizeToFitWidth = true
    }



    
}

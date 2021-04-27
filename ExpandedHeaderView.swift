//
//  ExpandedHeaderView.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/12/28.
//

import UIKit

protocol ExpandedHeaderViewDelegate {
    func toggleSection(header: ExpandedHeaderView, section: Int)
}

class ExpandedHeaderView: UITableViewHeaderFooterView {
    var delegate: ExpandedHeaderViewDelegate?
    var section: Int!
   
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer){
        let cell = gestureRecognizer.view as! ExpandedHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, section: Int, delegate: ExpandedHeaderViewDelegate) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        self.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.6958346963, blue: 0.4786360264, alpha: 0.8470588235)
        
//        let border5 = CALayer()
//        let width5 = CGFloat(0.5)
//        border5.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        border5.frame = CGRect(x: 0, y: 0, width:
//                                contentView.frame.size.width, height: 0.5)
//        border5.borderWidth = width5
//        self.contentView.layer.addSublayer(border5)
//        
//        let border = CALayer()
//        let width = CGFloat(0.5)
//        border.borderColor = UIColor.gray.cgColor
//        border.frame = CGRect(x: 0, y: contentView.frame.size.height, width:
//                                contentView.frame.size.width, height: 0.5)
//        border.borderWidth = width
//        self.contentView.layer.addSublayer(border)
    }
    
}

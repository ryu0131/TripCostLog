//
//  DoneTextField.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2021/02/20.
//

import UIKit

class DoneTextField: UITextField {

    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }

       private func commonInit(){
           let tools = UIToolbar()
           tools.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
           let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
           let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.closeButtonTapped))
           tools.items = [spacer, closeButton]
           self.inputAccessoryView = tools
       }

       @objc func closeButtonTapped(){
           self.endEditing(true)
           self.resignFirstResponder()
       }
    
}

//
//  Section.swift
//  tripcostlog
//
//  Created by 高木龍之介 on 2020/12/28.
//

import Foundation

struct Section {
    var title: String!
    var elements: [String]!
    var idArray: [Int]!
    var expanded: Bool!
    
    init(title: String, elements:[String], expanded: Bool, idArray: [Int]) {
        self.title = title
        self.elements = elements
        self.idArray = idArray
        self.expanded = expanded
    }
}

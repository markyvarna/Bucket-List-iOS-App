//
//  BucketListItem.swift
//  Bucket List
//
//  Created by Markus Varner on 8/23/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation

class BucketListItem : Equatable, Codable {
    //conform to equatable
    
    static func == (lhs: BucketListItem, rhs: BucketListItem) -> Bool {
        if lhs.title != rhs.title {return false}
        if  lhs.age != rhs.age {return false}
        if lhs.description != rhs.description {return false}
        return true
    }
    
    
    var title: String
    var age: Int
    var description: String
    
    init(title: String, age: Int, description: String) {
        self.title = title
        self.age = age
        self.description = description
    }
}

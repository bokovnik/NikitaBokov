//
//  User.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 30.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import Foundation
import RealmSwift

class News: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var author: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var authorPhoto_50: String = ""
    @objc dynamic var likeCount: Int = 0
    @objc dynamic var commentCount: Int = 0
    @objc dynamic var repostCount: Int = 0
    @objc dynamic var viewsCount: Int = 0
    @objc dynamic var photoURL_50: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

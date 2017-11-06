//
//  Photo.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 30.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var photoURL: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

//
//  User.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 30.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo_50: String = ""
}

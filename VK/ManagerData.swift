//
//  ManagerData.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 30.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class ManagerData {
    func loadFriendList(){
        let urlFriends = "https://api.vk.com/method/friends.get?user_id=1868775&fields=nickname&v=5.52&access_token=\(access_token)"
                
        Alamofire.request(urlFriends, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for (_, subJSON) in json["response"]["items"] {
                    let user = User()
                    user.id = subJSON["id"].intValue
                    user.firstName = subJSON["first_name"].stringValue
                    user.lastName = subJSON["last_name"].stringValue
                    user.photo_50 = subJSON["photo_50"].stringValue
                    userList.append(user)
//                print(user.firstName + " " + user.lastName)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func loadGroupList(){
        let urlFriends = "https://api.vk.com/method/groups.get?&extended=1&fields=name&v=5.52&access_token=\(access_token)"
        
        Alamofire.request(urlFriends, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for (_, subJSON) in json["response"]["items"] {
                    let group = Group()
                    group.id = subJSON["id"].intValue
                    group.name = subJSON["name"].stringValue
                    group.photo_50 = subJSON["photo_50"].stringValue
                    groupList.append(group)
                    //                print(user.firstName + " " + user.lastName)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func loadPhoto(){
        let urlFriends = "https://api.vk.com/method/photos.get?album_id=profile&user_id=1868775&v=5.52&access_token=\(access_token)"
        
        Alamofire.request(urlFriends, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for (_, subJSON) in json["response"]["items"] {
                    let photo = Photo()
                    photo.id = subJSON["id"].intValue
                    photo.photoURL = "" // пока неясно, что сюда идет
                    userPhoto.append(photo)
                    //                print(user.firstName + " " + user.lastName)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

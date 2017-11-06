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
        let urlFriends = "https://api.vk.com/method/friends.get?&fields=nickname&v=5.52&access_token=\(access_token)"
    
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
                    //print(user.firstName + " " + user.lastName)
                    //print(userList[0].firstName + " " + userList[0].lastName)
                }
                //print(userList.count)
                self.saveUser(userList)
                print(userList)
                loadData = true
            case .failure(let error):
                print(error)
                loadData = false
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
                self.saveGroup(groupList)
                print(groupList)
                loadData = true
            case .failure(let error):
                print(error)
                loadData = false
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
                self.savePhoto(userPhoto)
                print(userPhoto)
                loadData = true
            case .failure(let error):
                print(error)
                loadData = false
            }
        }
    }
    func saveUser(_ users: [User])  {
        do {
            let realm = try! Realm()
            realm.beginWrite()
            realm.add(users, update: true)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    func saveGroup(_ groups: [Group])  {
        do {
            let realm = try! Realm()
            print("REALM groups file:\(realm.configuration.fileURL)")

            realm.beginWrite()
            realm.add(groups, update: true)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    func savePhoto(_ photos: [Photo])  {
        do {
            let realm = try! Realm()
            realm.beginWrite()
            realm.add(photos, update: true)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    func getUser() -> [User] {
        let realm = try! Realm()
        var userList: [User] = []
        let data = realm.objects(User.self)
        for value in data {
            userList.append(value)
        }
        return userList
    }
    func getGroup() -> [Group] {
        let realm = try! Realm()
        var groupList: [Group] = []
        let data = realm.objects(Group.self)
        for value in data {
            groupList.append(value)
        }
        return groupList
    }
    func getPhoto() -> [Photo] {
        let realm = try! Realm()
        var photoList: [Photo] = []
        let data = realm.objects(Photo.self)
        for value in data {
            photoList.append(value)
        }
        return photoList
    }
}
var loadData: Bool? {
    get {
        return UserDefaults.standard.bool(forKey: "start") as Bool?
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "start")
    }
}

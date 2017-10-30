//
//  LoginFormController.swift
//  VK
//
//  Created by Боков Никита on 16.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit

let access_token = "af7da2fab723dad963f22fdd7542951fb77bee5a44b4d0b95d835d7f4f1ba5f622361aff1aa413f46b40e"// истечет в 22:00 31.10.2017

class LoginFormController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = ManagerData()
        manager.loadFriendList()
        manager.loadGroupList()
        manager.loadPhoto()
        
        //информация о пользователе - для урока 4
//        let userid = 210700286
        let url = "https://api.vk.com/method/users.get?user_id=210700286&v=5.52"
        Alamofire.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Информация о пользователе: \(json)")
            case .failure(let error):
                print(error)
            }
        }
   //список друзей пользователя
        let url2 = "https://api.vk.com/method/friends.get?user_id=1868775&fields=nickname&v=5.52&access_token=\(access_token)"
        Alamofire.request(url2, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Друзья пользователя: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    //фотографии пользователя
        let url3 = "https://api.vk.com/method/photos.get?album_id=profile&user_id=1868775&v=5.52&access_token=\(access_token)"
        Alamofire.request(url3, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Фотографии пользователя: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        //группы текущего пользователя
        let url4 = "https://api.vk.com/method/groups.get?v=5.52&access_token=\(access_token)"
        Alamofire.request(url4, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Группы текущего пользователя: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        //Получение групп по поисковому запросу
        let url5 = "https://api.vk.com/method/groups.search?q=Nigthwish&v=5.52&access_token=\(access_token)"
        Alamofire.request(url5, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Группы, найденные по запросу 'Nigthwish': \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
        LoginField.text = "admin"
        PasswordField.text = "123456"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var LoginField: UITextField!
    
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBAction func Enter(_ sender: UIButton) {
        if LoginField.text == "admin" &&
            PasswordField.text == "123456" {
        performSegue(withIdentifier: "go1", sender: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

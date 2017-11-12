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
import RealmSwift

var access_token: String = ""
//объявляем дефолтный объект для доступа к хранилищу NSUserDefaults
let userDefaults = UserDefaults.standard

class LoginFormController: UIViewController {

    @IBOutlet weak var webview: WKWebView! {
        didSet{
            webview.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6235615"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webview.load(request)

        

        /*    //Получение групп по поисковому запросу
        let url5 = "https://api.vk.com/method/groups.search?q=Nigthwish&v=5.52&access_token=\(access_token)"
        Alamofire.request(url5, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Группы, найденные по запросу 'Nigthwish': \(json)")
            case .failure(let error):
                print(error)
            }
        }*/
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

       /* performSegue(withIdentifier: "go1", sender: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LoginFormController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        access_token = params["access_token"] ?? ""
        
        print("Access token:\(access_token)")
        
        //сохраняем в NSUserDefaults информацию о том, что пользователь авторизован
        userDefaults.set(true, forKey: "userIsAutorized")
        
        //проверка
        print("userIsAutorized:\(userDefaults.bool(forKey: "userIsAutorized"))")
        
        decisionHandler(.cancel)
        //sleep(1)
        performSegue(withIdentifier: "go1", sender: nil)

    }
}

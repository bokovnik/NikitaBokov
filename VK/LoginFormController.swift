//
//  LoginFormController.swift
//  VK
//
//  Created by Боков Никита on 16.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

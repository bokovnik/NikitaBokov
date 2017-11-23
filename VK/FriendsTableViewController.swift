//
//  UserStoryTableViewController.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 19.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import UIKit
import RealmSwift

var userList = [User]()

class FriendsTableViewController: UITableViewController {

//    var friendList: [(String, UIImage?)] = [("Кэтрин Джейнвэй", UIImage(named: "Janeway")),("Чакотай",UIImage(named: "Chakotay")),("Тувок",UIImage(named: "Tuvok"))]
    let manager = ManagerData()
    var notificationToken: NotificationToken? = nil
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        
        //loadFriends = false
        //print("UserStoryTableViewController.viewDidLoad")
        
        if loadFriends != true {
            print("load Friend list from VK")
            manager.loadFriendList()
        }
        print("update Friend list from Realm DB")
        updateDataFromDB()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateDataFromDB() {
        let realm = try! Realm()
        let result = realm.objects(User.self)
        
        notificationToken = result.observe() {[weak self] (change: RealmCollectionChange) in
            switch change {
            case .initial:
                print("new")
                userList = self!.manager.getUser()
                self?.tableView.reloadData()
            //case .update(_, let deletions, let insertions, let modifications):
              case .update(_):
                print("update")
                userList = self!.manager.getUser()
                self?.tableView.reloadData()
            case .error(let newError):
                print(newError)
            }
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //print("Количество секций: 1")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        //print("Количество строк:\(userList.count)")
        return userList.count
    }

   let cellImage = UIImageView()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row].firstName + " " + userList[indexPath.row].lastName
        cell.imageView?.image = UIImage(named: "Janeway")
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


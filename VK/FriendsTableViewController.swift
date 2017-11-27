//
//  UserStoryTableViewController.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 19.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire


class FriendsTableViewController: UITableViewController {

//    var friendList: [(String, UIImage?)] = [("Кэтрин Джейнвэй", UIImage(named: "Janeway")),("Чакотай",UIImage(named: "Chakotay")),("Тувок",UIImage(named: "Tuvok"))]
    
    var userList = [User]()
    let manager = ManagerData()
    var notificationToken: NotificationToken? = nil
    let opq = OperationQueue()
    let getDataRequest = Alamofire.request("https://api.vk.com/method/friends.get?&fields=nickname,photo_50&v=5.52&access_token=\(access_token)")
    
    override func viewDidLoad() {
 
        super.viewDidLoad()
        
        //loadFriends = false
        //print("UserStoryTableViewController.viewDidLoad")
        
        let getDataOperation = GetDataOperation(request: getDataRequest)

        opq.addOperation(getDataOperation)
        
        let parseData = ParseFriendsData()
        parseData.addDependency(getDataOperation)
        opq.addOperation(parseData)
        
        let reloadTableController = ReloadFriendsTableController(controller: self)
        reloadTableController.addDependency(parseData)
        OperationQueue.main.addOperation(reloadTableController)
        
        /*if loadFriends != true {
            print("load Friend list from VK")
            manager.loadFriendList()
        }*/
//        print("update Friend list from Realm DB")
//        updateDataFromDB()
        
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
                self!.userList = self!.manager.getUser()
                self?.tableView.reloadData()
            //case .update(_, let deletions, let insertions, let modifications):
              case .update(_):
                print("update")
                self!.userList = self!.manager.getUser()
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

   //let cellImage = UIImageView()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row].firstName + " " + userList[indexPath.row].lastName
        let queue = OperationQueue()
        //print("friendPhoto: \(userList[indexPath.row].photo_50)")
        let load1 = LoadImage(url: userList[indexPath.row].photo_50)
        queue.addOperation(load1)

        load1.completionBlock = {
            OperationQueue.main.addOperation() {
        cell.imageView?.image = load1.image //UIImage(named: "Janeway")

        // Configure the cell...
            }
        }
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        let getDataOperation = GetDataOperation(request: getDataRequest)
        
        opq.addOperation(getDataOperation)
        
        let parseData = ParseFriendsData()
        parseData.addDependency(getDataOperation)
        opq.addOperation(parseData)
        
        let reloadTableController = ReloadFriendsTableController(controller: self)
        reloadTableController.addDependency(parseData)
        OperationQueue.main.addOperation(reloadTableController)
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


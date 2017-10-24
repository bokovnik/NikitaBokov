//
//  MyGroupsTableViewController.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 24.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import UIKit

class MyGroupsTableViewController: UITableViewController {

    var MyGroupList: [(String, UIImage?)] = [("Планета Земля", UIImage(named: "Earth")),("Солнечная система",UIImage(named: "SolarSystem")),("Млечный путь",UIImage(named: "MilkyWay"))]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MyGroupList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myGroups", for: indexPath)
        cell.textLabel?.text = MyGroupList[indexPath.row].0
        cell.imageView?.image = MyGroupList[indexPath.row].1
        // Configure the cell...

        return cell
    }
 
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        //print("сегвей: \(segue.identifier)")
        if segue.identifier == "addGroup" {
            let groupsController = segue.source as! GroupsTableViewController
            if let indexPath = groupsController.tableView.indexPathForSelectedRow {
                let group = groupsController.groupList[indexPath.row]
                MyGroupList.append((group.0, group.1))
                tableView.reloadData()
            }
        }
    }

    override func tableView(  _ tableView:  UITableView, commit editingStyle:  UITableViewCellEditingStyle,  forRowAt indexPath:  IndexPath)  {
        //  если  была  нажата к нопка  удалить
        if  editingStyle  == .  delete {
            //  мы  удаляем г ород  из  массива
            MyGroupList.remove( at:  indexPath.row)
            // и  удаляем  строку  из таблицы
            tableView.deleteRows(at:  [indexPath] ,  with:  .fade)
        }
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

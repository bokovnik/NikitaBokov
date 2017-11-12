//
//  FriendPhotoCollectionViewController.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 24.10.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

var userPhoto = [Photo]()

class FriendPhotoCollectionViewController: UICollectionViewController {

    let manager = ManagerData()
    var notificationToken: NotificationToken? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //loadPhotos = false
        
        if loadPhotos != true {
            print("load user photos from VK")
            manager.loadPhoto()
        }
        print("update user photos from Realm DB")
        updateDataFromDB()
        
        //self.collectionView!.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateDataFromDB() {
        let realm = try! Realm()
        let result = realm.objects(Photo.self)
        
        notificationToken = result.observe() {[weak self] (change: RealmCollectionChange) in
            switch change {
            case .initial:
                print("new")
                userPhoto = self!.manager.getPhoto()
                self?.collectionView?.reloadData()
            //case .update(_, let deletions, let insertions, let modifications):
            case .update(_):
                print("update")
                userPhoto = self!.manager.getPhoto()
                self?.collectionView?.reloadData()
            case .error(let newError):
                print(newError)
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userPhoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let myImageView: UIImageView = cell.viewWithTag(1) as! UIImageView
        
        myImageView.image = UIImage(named: "JanewayPhoto")
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

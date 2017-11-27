//
//  AsyncOperation.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 27.11.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class AsyncOperation : Operation {
    
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    override func cancel() {
        super.cancel()
        state = .finished
    }
    
}

class GetDataOperation: AsyncOperation {
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    private var request: DataRequest
    var data: Data?
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    init(request: DataRequest) {
        self.request = request
    }
    
}

class ParseFriendsData: Operation {
    
    var userList: [User] = []
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data else { return }
        let json = JSON(data)
        
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
        //let md = ManagerData()
        //md.saveUser(userList)
        }        
    }


class ReloadFriendsTableController: Operation {
    var controller: FriendsTableViewController
    
    init(controller: FriendsTableViewController) {
        self.controller = controller
    }
    
    override func main() {
        guard let parseData = dependencies.first as? ParseFriendsData else { return }
        controller.userList = parseData.userList
        controller.tableView.reloadData()
    }
}

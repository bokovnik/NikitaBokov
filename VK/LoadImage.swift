//
//  LoadImage.swift
//  VK_NikitaBokov
//
//  Created by Боков Никита on 27.11.2017.
//  Copyright © 2017 Боков Никита. All rights reserved.
//

import Foundation
import UIKit

class LoadImage: Operation {
    
    var image = UIImage()
    var imageData: Data?
    let url1: URL?
    
    override func main() {
        //print("1. start \(Thread.current)")
        guard url1 != nil else {return}
        do {
            imageData = try  Data(contentsOf: url1!)
            //print("2. dataload \(imageData) \(Thread.current)")
        } catch{
            print("error")
        }
        if let value =  imageData{
            image = UIImage(data: value)!
            //print("3. image \(image) \(Thread.current)")
        }
        //print("4. return \(image) \(Thread.current)")
    }
    
    init(url: String) {
        self.url1 = URL(string: url)
    }
    
}

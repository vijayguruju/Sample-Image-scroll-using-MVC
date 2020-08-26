//
//  FlickrModelObject.swift
//  FlickrImage
//
//  Created by Dinesh Sunder on 23/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

import Foundation

class PhotoResponse {
    var photos = [Photos]()
    
    init(photosResponseArray:[[String:Any]]) {
        for dict in photosResponseArray{
            self.photos.append(Photos(photosDict: dict))
        }
    }
    
}

class Photos{

    var id = String()
    var owner = String()
    var secret = String()
    var server = String()
    var farm = String()
    var title = String()
    var isPublic = Int()
    var isFriend = Int()
    var isFamily = Int()
    
    init(photosDict:[String:Any]) {
        self.id = "\(photosDict["id"] ?? "")"
        self.owner = "\(photosDict["owner"] ?? "")"
        self.secret = "\(photosDict["secret"] ?? "")"
        self.server = "\(photosDict["server"] ?? "")"
        self.farm = "\(photosDict["farm"] ?? "")"
        self.title = "\(photosDict["title"] ?? "")"
    }
    
}

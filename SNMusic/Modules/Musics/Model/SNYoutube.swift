//
//  SNYoutube.swift
//  SNMusic
//
//  Created by Darcy on 2021/7/18.
//

import HandyJSON

class SNVideo : HandyJSON {
    
    required init() {}

    var videos : [SNYoutube]!
    
}

class SNYoutube: HandyJSON {
    
    required init() {}
    
    var title : String!
    
    var url : String!
    
    var channelTitle : String!
    
}

//
//  SNMusic.swift
//  SNMusic
//
//  Created by Darcy on 2021/7/12.
//

import HandyJSON

class SNMusic: HandyJSON {
        
    func ablumName() -> String {
        
        return "未知"
    }
    
    func artistName() -> String {
        
        return "未知"
    }
    
    func musicURL() -> URL {
        return URL(string: self.url)!
    }
    
    func image() -> UIImage? {
        
        return nil
    }
        
    required init() {
        self.name = ""
    }
    
    var singer : String?
    
    var name : String
    
    var url : String?
    
    var created_time : String?
}

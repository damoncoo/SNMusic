//
//  SNMusicProvider.swift
//  Yi
//
//  Created by Cxy on 2021/1/21.
//

import Foundation
import PromiseKit

protocol SNMusicItem {
    
    func musicUrl() -> String
}

protocol SNMusicProvider {
    
    func musics() -> Promise< [SNMusicItem] >
}

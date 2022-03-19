//
//  SNMusicPlayerPresenter.swift
//  SNMusic
//
//  Created by Darcy on 2021/6/2.
//

import Foundation
import YiCore
import PromiseKit
import HandyJSON
import Alamofire

class SNMusicPlayerPresenter {
    
    
}

class SNMusicNewJobPresenter<T : HandyJSON> {
    
    func searchMusic(title : String, singer : String , url : String ) -> Promise<Bool>  {

        return Promise { p in

            let promise : Promise<Response<T>> = ApiClient.shared.session.searchMusic(singer: singer, name: title, url: url) as  Promise<Response<T>>
            promise.done { (apply) in
                p.fulfill(true)
            }.catch { (err) in
                p.reject(err)
            }
        }
    }
    
}

extension ApiSession {
    
    func searchMusic<T>(singer : String, name : String , url : String) ->  Promise<Response<T>>  {
        
        let paras : Dictionary<String, Any> = ["singer": singer, "name" : name, "url" : url]
        return self.R(path: "/api/v2/music/job/" , method: .post, data: paras)
        
    }
    
}

class Youtube: URLConvertible {
    
    let q : String
    init(keyWord: String) {
        self.q = keyWord
    }
    
    func asURL() throws -> URL {
        return URL(string: "http://yt.seungyu.cn/yt/search?title=" + self.q.urlEncoded)!
    }
}

class SNSearchPresenter : NSObject {
    
    public static let presenter = SNSearchPresenter()

    func searchYoutube(keyWord: String) -> Promise<[SNYoutube]> {

        return Promise<[SNYoutube]> { p in
            AF.request(Youtube(keyWord: keyWord)).validate().response { res in

                switch res.result {
                case .success(let data):

                    let content = data?.string(encoding: .utf8)
                    let videoInfo = JSONDeserializer<SNVideo>.deserializeFrom(json: content)
//                    guard let videoInfo = videoInfo else  {
//                        p.reject(SNError.commonError("获取失败"))
//                        return
//                    }
                    p.fulfill(videoInfo!.videos)

                case .failure(let error) :
                    p.reject(error)
                }
            }
        }
    }
}


